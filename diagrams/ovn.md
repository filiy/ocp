graph TD
    subgraph Physical_Network ["Physical Network (Underlay)"]
        PhysNet("Physical Interface (eth0/ens3)")
    end

    subgraph OVN_Logical_Topology ["OVN Logical Topology (Overlay)"]
        
        %% External Connection Layer
        subgraph External_Bridge_Layer ["External Bridge Layer"]
            br_ex("br-ex (Bridge)")
            localnet("Localnet Port")
            ExtSwitch("External Switch<br/>(a9e688f8-...)")
        end

        %% Gateway Router Layer
        subgraph Gateway_Router_Block ["Gateway Router (North/South Traffic)"]
            GR("Gateway Router<br/>GR_ip-10-0-2-210<br/>(5e81eb61-...)")
            SNAT_List["NAT Table<br/>(SNAT: 10.128.x.x -> 10.0.2.210)<br/>100+ Rules Defined"]
        end

        %% Join Subnet Layer
        subgraph Join_Layer ["Join Subnet (100.64.0.0/16)"]
            JoinSwitch("Join Switch<br/>(afccba64-...)")
        end

        %% Cluster Router Layer
        subgraph Cluster_Router_Block ["Cluster Router (East/West Traffic)"]
            OvClusterRouter("ovn_cluster_router<br/>(838d1d39-...)")
        end

        %% Node Switch Layer
        subgraph Node_Switch_Layer ["Node Switch (10.128.0.0/23)"]
            NodeSwitch("Node Switch<br/>(71e7fc48-...)")
        end

        %% Pods Layer
        subgraph Pods_Layer ["Workloads (Sample)"]
            Pod1("Pod: app1-web<br/>10.128.1.238")
            Pod2("VM: virt-launcher-win11<br/>10.128.0.33")
            Pod3("Svc: prometheus-operator<br/>10.128.1.134")
        end
    end

    %% Connections
    PhysNet --- br_ex
    br_ex --- localnet
    localnet --- ExtSwitch
    ExtSwitch -- "rtoe-GR (Mac: 02:12...)" --> GR
    GR --- SNAT_List
    GR -- "rtoj-GR (100.64.0.2)" --> JoinSwitch
    JoinSwitch -- "jtor-ovn_cluster_router" --> OvClusterRouter
    OvClusterRouter -- "rtos-ip-10-0-2-210 (10.128.0.1)" --> NodeSwitch
    NodeSwitch --- Pod1
    NodeSwitch --- Pod2
    NodeSwitch --- Pod3

    %% Styling
    classDef router fill:#f9f,stroke:#333,stroke-width:2px;
    classDef switch fill:#bbf,stroke:#333,stroke-width:2px;
    classDef phys fill:#dfd,stroke:#333,stroke-width:2px;
    
    class GR,OvClusterRouter router;
    class ExtSwitch,JoinSwitch,NodeSwitch switch;
    class PhysNet,br_ex phys;