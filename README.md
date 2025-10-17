1. Every folder has a child named 'TYPE.lua' which gives information about what Class of Instance the folder represents.
2. If a property of the Class is written, that means that is the custom property being used (eg. if workspace's TYPE.lua file has an entry saying Gravity = 200, that means workspace.Gravity has been set to 200,
   otherwise, if nothing is specified, that means the Gravity is kept at its default value of 196.2
3. Any extra information is stored as comments.
