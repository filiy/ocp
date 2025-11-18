graph TD
    subgraph OVS_Bridges ["Open vSwitch Data Plane (Local Host)"]
        br_int("br-int (Integration Bridge)")
        br_ex("br-ex (External Bridge)")

        br_int_internal("br-int (Internal Interface)")
        br_ex_internal("br-ex (Internal Interface)")

        patch_int("patch-br-int-to-br-ex")
        patch_ex("patch-br-ex-to-br-int")
        
        ovnk8s_mp0("ovn-k8s-mp0 (To OVN Logical Network)")
        
        phy_if("enp126s0 (Physical Interface)")
        
        subgraph Pod_Interfaces ["Pod VIFs (Container/VM Interfaces)"]
            int_ports("~100 Pod Interface Ports (e.g., 27c668d853d17c0)")
        end
    end

    %% Connections
    br_int -- "Has internal port" --> br_int_internal
    br_ex -- "Has internal port" --> br_ex_internal

    %% br-int Connections
    br_int -- "Multiple Ports" --> int_ports
    br_int -- "Internal Port" --> ovnk8s_mp0
    br_int -- "Patch Port" --> patch_int

    %% br-ex Connections
    br_ex -- "Patch Port" --> patch_ex
    br_ex -- "Physical Port" --> phy_if

    %% Patch Link (Connects br-int and br-ex)
    patch_int -- "Peer: patch-br-ex-to-br-int" --> patch_ex

    %% Styling
    classDef bridge fill:#bbf,stroke:#333,stroke-width:2px;
    classDef patch fill:#f9f,stroke:#333,stroke-width:2px,stroke-dasharray: 5 5;
    classDef physical fill:#dfd,stroke:#333,stroke-width:2px;
    classDef internal_port fill:#ccc,stroke:#333;
    
    class br_int,br_ex bridge;
    class patch_int,patch_ex patch;
    class phy_if physical;
    class br_int_internal,br_ex_internal,ovnk8s_mp0 internal_port;