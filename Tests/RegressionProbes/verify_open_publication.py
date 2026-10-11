"""Exercise the actual open publication block under a deterministic lock boundary.
This isolated probe is not a full native GUI/Keychain test. Synthetic values only.
"""
from pathlib import Path
import subprocess
import sys

root = Path(__file__).resolve().parents[2]
source = (root / 'Sources/MosaicDemo/ProtectedDemoView.swift').read_text()
block = source.split('identity.setupComplete = true\n', 1)[1].split('            } catch', 1)[0]
block = '\n'.join(line for line in block.splitlines() if 'JSONEncoder' not in line)
probe = root / '.verification/open-publication-probe'
probe.mkdir(parents=True, exist_ok=True)
program = '''import Foundation
@MainActor final class Service {
    var beforeReturn: () -> Void = {}
    func page() async throws -> [String] {
        // Models a lock between the service result becoming ready and UI publication.
        beforeReturn()
        return ["SYNTHETIC CONTENT"]
    }
}
@MainActor final class Model {
    let service = Service()
    var epoch = UUID()
    var unlocked = false
    var captures: [String] = []
    var message = "Locked"
    var working = false
    func lock() { epoch = UUID(); unlocked = false; captures = []; message = "Locked"; working = false }
    func open() async throws {
        let ticket = epoch
''' + block + '''
    }
}
@main struct Probe {
    @MainActor static func main() async throws {
        let model = Model()
        model.service.beforeReturn = { model.lock() }
        try await model.open()
        guard model.captures.isEmpty, !model.unlocked, model.message == "Locked" else {
            print("FAIL: stale opening result published after lock")
            exit(1)
        }
        print("PASS: lock before publication keeps content hidden")
        model.service.beforeReturn = {}
        try await model.open()
        guard model.unlocked, model.captures.count == 1 else {
            print("FAIL: valid opening result was not published")
            exit(1)
        }
        print("PASS: current opening result is published")
    }
}
'''
path = probe / 'Probe.swift'
path.write_text(program)
compiler = subprocess.run(['swiftc', '-swift-version', '6', '-parse-as-library',
    '-module-cache-path', str(root / '.verification/clang-cache'), str(path),
    '-o', str(probe / 'Probe')], capture_output=True, text=True)
if compiler.returncode:
    print(compiler.stderr)
    sys.exit(compiler.returncode)
sys.exit(subprocess.run([str(probe / 'Probe')]).returncode)
