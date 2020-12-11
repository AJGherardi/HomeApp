String watchStateSubscription = """
  subscription WatchState(\$groupAddr: Int!, \$devAddr: Int!, \$elemAddr: Int!) {
    watchState(groupAddr: \$groupAddr, devAddr: \$devAddr, elemAddr: \$elemAddr)
  }
""";

String setStateMutation = """
  mutation SetState(\$groupAddr: Int!, \$elemAddr: Int!, \$value: String!) {
    setState(groupAddr: \$groupAddr, elemAddr: \$elemAddr, value: \$value)
  }
""";

String sceneRecallMutation = """
  mutation SceneRecall(\$groupAddr: Int!, \$sceneNumber: Int!) {
    sceneRecall(groupAddr: \$groupAddr, sceneNumber: \$sceneNumber) 
  }
""";

String eventBindMutation = """
  mutation EventBind(\$sceneNumber: String!, \$groupAddr: String!, \$devAddr: Int!, \$elemAddr: String!) {
    eventBind(sceneNumber: \$sceneNumber, groupAddr: \$groupAddr, devAddr: \$devAddr, elemAddr: \$elemAddr)
  }
""";

String addDeviceMutation = """
  mutation AddDevice(\$name: String!, \$devUUID: String!, \$groupAddr: Int!) {
    addDevice(name: \$name, devUUID: \$devUUID, groupAddr: \$groupAddr)
  }
""";

String resetHubMutation = """
  mutation ResetHub {
    resetHub
  }
""";

String addGroupMutation = """
  mutation AddGroup(\$name: String!) {
    addGroup(name: \$name)
  }
""";

String getUserPinQuery = """
  query getUserPin {
    getUserPin
  }
""";

String sceneStoreMutation = """
  mutation SceneStore(\$groupAddr: Int!, \$name: String!) {
    sceneStore(groupAddr: \$groupAddr, name: \$name) 
  }
""";

String availableDevicesQuery = """
  query AvailableDevices {
    availableDevices
  }
""";

String watchGroupSubscription = """
  subscription WatchGroup(\$groupAddr: Int!) {
    watchGroup(groupAddr: \$groupAddr) {
      group {
        devices {
          addr
          device {
            type
            elements { 
              addr
              element {
                name
                stateType
                state
              }
            }
          }
        }
        scenes {
          number
          scene {
            name
          }
        }
      }
    }
  }
""";

String availableGroupsQuery = """
  query AvailableGroups {
    availableGroups {
      addr
      group {
        name
        devices {
            addr
            device {
              type
              elements { 
                addr
                element {
                  name
                  stateType
                  state
                }
              }
            }
          }
          scenes {
            number
            scene {
              name
            }
          }
        }
      }
  }
""";

String configHubMutation = """
  mutation ConfigHub {
    configHub
  }
""";

String addUserMutation = """
  mutation AddUser {
    addUser
  }
""";

String removeDeviceMutation = """
  mutation RemoveDevice(\$devAddr: Int!, \$groupAddr: Int!) {
    removeDevice(devAddr: \$devAddr, groupAddr: \$groupAddr)
  }
""";

String removeGroupMutation = """
  mutation RemoveGroup(\$groupAddr: Int!) {
    removeGroup(groupAddr: \$groupAddr)
  }
""";
