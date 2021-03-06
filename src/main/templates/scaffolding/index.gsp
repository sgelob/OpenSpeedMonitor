<!DOCTYPE html>
<html>
    <head>
        <g:set var="entityName" value="\${message(code: '${propertyName}.label', default: '${className}')}" scope="request"/>
        <meta name="layout" content="kickstart" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <div id="list-${propertyName}" class="content scaffold-list" role="main">
            <g:if test="\${flash.message}">
                <div class="message" role="status">\${flash.message}</div>
            </g:if>
            <f:table collection="\${${propertyName}List}" />

            <div>
                <bs:paginate total="\${${propertyName}Count ?: 0}" />
            </div>
        </div>
    </body>
</html>