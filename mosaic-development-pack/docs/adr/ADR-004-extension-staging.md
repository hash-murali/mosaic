# ADR 004 Share extension staging

Status proposed, blocks extension release. Date 2026-10-02.

Context: capture while vault locked without overbroad key sharing. Decision direction: only protected staging in app group; main app performs adoption and inference. Candidate reviewed staging-only envelope/key scheme permits deposit without full vault access. If not securely supported, require unlock/main-app capture instead.

Do not select a new asymmetric protocol from scratch merely to make capture seamless. Validate established library/OS mechanism and file coordination. MOS-005 exit: wrong process cannot decrypt vault; locked intake retains confidentiality; killed extension/adoption retries without loss/duplication; ephemeral handles not called saved before durable receipt. Affects R08 and T11.
