###
API-Defs
=========
###

t = require('decl-api').types

###
#Rules
###

api = {}

###
#Framework
###
api.framework = {
  events:
    deviceAdded:
      description: "A new device was added to the devices list"
      params:
        device:
          type: t.object
          toJson: yes
    deviceAttributeChanged:
      description: "The value of a device attribute changed"
      params:
        event:
          type: t.object
          properties:
            device:
              type: t.object
              toJson: yes
            attributeName:
              type: t.string
            attribute:
              type: t.object
            time:
              type: t.date
            value: 
              type: t.any
    messageLogged:
      description: "A new log message was emitted"
      params:
        event:
          type: t.object
          properties:
            level:
              type: t.string
            msg:
              type: t.string
            meta:
              type: t.object
  actions:
    getAllDevicesJson:
      rest:
        type: "GET"
        url: "/api/devices"
      description: "Lists all devices"
      params: {}
      result:
        devices:
          type: t.array
          toJson: yes 
    getDeviceById:
      description: "Lists all devices"
      rest:
        type: "GET"
        url: "/api/devices/:deviceId"
      params:
        deviceId:
          type: t.string
      result:
        device:
          type: t.object
          toJson: yes
    addPluginsToConfig:
      description: "Add plugins to config"
      rest:
        type: "POST"
        url: "/api/config/plugins"
      params:
        pluginNames:
          type: t.array
      result:
        added:
          type: t.array
    removePluginsFromConfig:
      description: "Remove plugins from config"
      rest:
        type: "DELETE"
        url: "/api/config/plugins"
      params:
        pluginNames:
          type: t.array
      result:
        removed:
          type: t.array
    restart:
      description: "Restart pimatic"
      rest:
        type: "POST"
        url: "/api/restart"
      result: {}
    getAllPages:
      rest:
        type: "GET"
        url: "/api/pages"
      description: "Lists all pages"
      params: {}
      result:
        pages:
          type: t.array
    getPageById:
      description: "Get a page by id"
      rest:
        type: "GET"
        url: "/api/pages/:pageId"
      params:
        pageId:
          type: t.string
      result:
        page:
          type: t.object
    removePage:
      description: "Remove page"
      rest:
        type: "DELETE"
        url: "/api/pages/:pageId"
      params:
        pageId:
          type: t.string
      result:
        removed:
          type: t.object
    addPage:
      rest:
        type: "POST"
        url: "/api/pages/:pageId"
      description: "Add a page"
      params:
        pageId:
          type: t.string
        page:
          type: t.object
      result:
        page:
          type: t.object
    updatePage:
      rest:
        type: "PATCH"
        url: "/api/pages/:pageId"
      description: "Update a page"
      params:
        pageId:
          type: t.string
        page:
          type: t.object
      result:
        page:
          type: t.object
    addDeviceToPage:
      rest:
        type: "POST"
        url: "/api/pages/:pageId/:deviceId"
      description: "Add a page"
      params:
        pageId:
          type: t.string
        deviceId:
          type: t.string
      result:
        deviceItem:
          type: t.object
}

api.rules = {
  actions:
    addRuleByString:
      description: "Adds a rule by a string"
      rest:
        type: "POST"
        url: "/api/rules/:ruleId"
      params: 
        ruleId:
          type: t.string
        rule:
          type: t.object
          properties:
            name:
              type: t.string
            ruleString:
              type: t.string
            active:
              type: t.boolean
              optional: yes
            logging:
              type: t.boolean
              optional: yes
        force: 
          type: t.boolean
          optional: yes
    updateRuleByString:
      rest:
        type: "PATCH"
        url: "/api/rules/:ruleId"
      description: "Updates a rule by a string"
      params:
        ruleId:
          type: t.string
        rule:
          type: t.object
          properties:
            name:
              type: t.string
              optional: yes
            ruleString:
              type: t.string
              optional: yes
            active:
              type: t.boolean
              optional: yes
            logging:
              type: t.boolean
              optional: yes
    removeRule:
      rest:
        type: "DELETE"
        url: "/api/rules/:ruleId"
      description: "Remove the rule with the given id"
      params:
        ruleId:
          type: t.string
    getAllRules:
      rest:
        type: "GET"
        url: "/api/rules"
      description: "Lists all rules"
      params: {}
    getRuleById:
      rest:
        type: "GET"
        url: "/api/rules/:ruleId"
      description: "Lists all rules"
      params: 
        ruleId:
          type: t.string
}

###
#Variables
###

variableParams = {
  name:
    type: t.string
  type:
    type: t.string
    oneOf: ["expression", "value"]
  valueOrExpression:
    type: t.any
}

variableResult = {
  variable:
    type: t.object
    toJson: yes
}

api.variables = {
  actions:
    getAllVariables:
      description: "Lists all variables"
      rest:
        type: "GET"
        url: "/api/variables"
      params: {}
      result:
        variables:
          type: t.array
          toJson: yes
    updateVariable:
      description: "Updates a variable value or expression"
      rest:
        type: "PATCH"
        url: "/api/variables/:name"
      params: variableParams
      result: variableResult
    addVariable:
      description: "Adds a value or expression variable"
      rest:
        type: "POST"
        url: "/api/variables/:name"
      params: variableParams
      result: variableResult
    getVariableByName:
      description: "Get infos about a variable"
      rest:
        type: "GET"
        url: "/api/variables/:name"
      params:
        name:
          type: t.string
      result: variableResult
    removeVariable:
      desciption: "Remove a variable"
      rest:
        type: "DELETE"
        url: "/api/variables/:name"
      params:
        name:
          type: t.string
      result: variableResult

}


###
#Plugins
###
api.plugins = {
  actions:
    getInstalledPluginsWithInfo:
      description: "Lists all installed plugins"
      rest:
        type: "GET"
        url: "/api/plugins"
      params: {}
      result:
        plugins:
          type: t.array
    searchForPluginsWithInfo:
      description: "Searches for available plugins"
      rest:
        type: "GET"
        url: "/api/available-plugins"
      params: {}
      result:
        plugins:
          type: t.array
    getOutdatedPlugins:
      description: "Get outdated plugins"
      rest:
        type: "GET"
        url: "/api/outdated-plugins"
      params: {}
      result:
        outdatedPlugins:
          type: t.array
    isPimaticOutdated:
      description: "Is pimatic outdated"
      rest:
        type: "GET"
        url: "/api/outdated-pimatic"
      params: {}
      result:
        outdated: 
          tye: 'any'
    installUpdatesAsync:
      description: "Install Updates without awaiting result"
      rest:
        type: "POST"
        url: "/api/update-async"
      params:
        modules:
          type: t.array
      result:
        status:
          type: 'any'
}


###
#Database
###
messageCriteria = {
  criteria:
    type: t.object
    optional: yes
    properties:
      level:
        type: 'any'
        optional: yes
      levelOp:
        type: t.string
        optional: yes
      after:
        type: t.date
        optional: yes
      before:
        type: t.date
        optional: yes
      limit:
        type: Number
        optional: yes
}
  
dataCriteria = {
  criteria:
    type: t.object
    optional: yes
    properties:
      deviceId:
        type: t.any
      attributeName:
        type: t.any
      after:
        type: t.date
      before:
        type: t.date
}

api.database = {
  actions:
    queryMessages:
      desciption: "list log messages"
      rest:
        type: 'GET'
        url: '/api/database/messages'
      params: messageCriteria
      result:
        messages:
          type: t.array
    deleteMessages:
      description: "delets messages older than the given date"
      rest:
        type: 'DELETE'
        url: '/api/database/messages'
      params: messageCriteria
    addDeviceAttributeLogging:
      description: "enable or disable logging for an device attribute"
      params:
        deviceId:
          type: t.string
        attributeName:
          type: t.string
        time:
          type: t.any
    queryMessagesTags:
      description: "lists all tags from the matching messages"
      rest:
        type: 'GET'
        url: '/api/database/messages/tags'
      params: messageCriteria
      result:
        tags:
          type: t.array
    queryMessagesCount:
      description: "count of all matches matching the criteria"
      rest:
        type: 'GET'
        url: '/api/database/messages/count'
      params: messageCriteria
      result:
        count:
          type: Number
    queryDeviceAttributeEvents:
      rest:
        type: 'GET'
        url: '/api/database/device-attributes/'
      description: "get logged values of device attributes"
      params: dataCriteria
      result:
        events:
          type: t.array
    getDeviceAttributeLogging:
      description: "get device attribute logging times table"
      params: {}
      result:
        attributeLogging:
          type: t.array
    setDeviceAttributeLogging:
      description: "set device attribute logging times table"
      params:
        attributeLogging:
          type: t.array
    getDeviceAttributeLoggingTime:
      description: "get device attribute logging times table"
      params:
        deviceId:
          type: t.string
        attributeName:
          type: t.string
      result:
        timeInfo:
          type: t.object
}

# all
actions = {}
for a in [api.framework, api.rules, api.variables, api.plugins, api.database]
  for actionName, action of a.actions
    actions[actionName] = action
api.all = {actions}

module.exports = api