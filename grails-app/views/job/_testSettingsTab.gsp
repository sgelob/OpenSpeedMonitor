<%@ page import="de.iteratec.osm.measurement.schedule.JobGroup" %>
<%@ page import="de.iteratec.osm.measurement.schedule.ConnectivityProfile" %>


<g:render template="checkbox" model="${['booleanAttribute': 'active', 'job': job]}"/>

<div class="form-group ${hasErrors(bean: job, field: 'executionSchedule', 'error')}">
    <label class="col-md-2 control-label" for="executionScheduleShown">
        <g:message code="job.executionSchedule.label" default="executionSchedule"/>
    </label>

    <div class="col-md-8">
        <div class="form-inline">
            <input type="text" id="execution-schedule-shown" class="form-control"
                   value="${job.executionSchedule ? job.executionSchedule.substring(job.executionSchedule.indexOf(' ') + 1, job.executionSchedule.size()) : ''}"
                   onchange="updateExecScheduleInformations('0 ' + this.value, '${createLink(action: 'nextExecution')}')">
            <i class="fa fa-question-circle fa-lg clickable-icon" onclick="toggleCronInstructions()"></i>
        </div>
        <input type="text" id="execution-schedule" name="executionSchedule" value="${job?.executionSchedule}" style="display: none">
        <br><span id="cronhelp-readable-expression"></span>
        <br><span id="cronhelp-next-execution"></span>
        <br>
        <span id="cron-instructions" style="display: none;">
            <h3><g:message code="job.cronInstructions.header" default="Cron expressions for measurement jobs"/></h3>
            <g:render template="cronInstructions"></g:render>
        </span>
    </div>
</div>


<div class="form-group ${hasErrors(bean: job, field: 'jobGroup', 'error')} required">
    <label class="col-md-2 control-label" for="jobGroup">
        <g:message code="job.jobGroup.label" default="jobGroup"/>
        <span class="required-indicator">*</span>
    </label>

    <div class="col-md-8">
        <g:select id="jobgroup" class="form-control chosen" name="jobGroup.id" from="${JobGroup.list()}"
                  value="${job?.jobGroup?.id}" optionValue="name" optionKey="id"/>
        <a id="jobGroupModalLink" href="#jobGroupModal" role="button" class="btn btn-xs" data-toggle="modal"><g:message
                code="default.button.create.new" default="Create New"/></a>
    </div>
</div>

<div class="form-group">
    <label class="col-md-2 control-label" for="connectivityProfile"><g:message
            code="connectivityProfile.label" default="connectivityProfile"/>
        <span class="required-indicator">*</span>
    </label>

    <div class="col-md-8">
        <g:select id="connectivityProfile" class="chosen"
                  data-placeholder="${g.message(code: 'web.gui.jquery.chosen.multiselect.placeholdermessage', 'default': 'Please chose an option')}"
                  name="connectivityProfile.id" from="${connectivites}" optionKey="id"
                  value="${job.connectivityProfile ? job.connectivityProfile.id : null}"/>
    </div>
</div>

<div id="connectivityProfileDetails">
    <input type="hidden" id="customConnectivityProfile" name="customConnectivityProfile"
           value="${job?.customConnectivityProfile}"/>
    <input type="hidden" id="noTrafficShapingAtAll" name="noTrafficShapingAtAll" value="${job?.noTrafficShapingAtAll}"/>

    <div class="form-group">
        <label class="col-md-2 control-label" for="customConnectivityName">
            <g:message code="job.customConnectivityProfile.label" default="Name of custom connectivity profile"/>
        </label>

        <div class="col-md-8">
            <g:textField class="form-control" name="customConnectivityName" id="custom-connectivity-name"
                         value="${job?.customConnectivityName}" readonly="readonly"/>
            <label class="checkbox-inline">
                <g:checkBox name="setCustomConnNameManually" id="setCustomConnNameManually"></g:checkBox>
                <g:message code="job.customConnectivityProfile.setnamemanually.label" default="Set name manually."/>
            </label>
        </div>
    </div>
    <g:each var="attribute" in="['bandwidthDown', 'bandwidthUp', 'latency', 'packetLoss']">
        <div class="form-group ${hasErrors(bean: job, field: attribute, 'error')}">
            <label class="col-md-2 control-label" for="${attribute}">
                <g:message code="connectivityProfile.${attribute}.label"
                           default="${attribute}"/>
            </label>

            <div class="col-md-8">
                <g:textField class="form-control" name="${attribute}" id="custom-${attribute}"
                             value="${job?."$attribute"}"/>
            </div>
        </div>
    </g:each>
</div>

<div class="form-group ${hasErrors(bean: job, field: 'description', 'error')} required">
    <label for="description" class="col-md-2 control-label">
        <g:message code="job.description.label" default="description"/>
    </label>

    <div class="col-md-10">
        <textarea class="form-control" name="description" id="description"
                  rows="3">${job?.description?.trim()}</textarea>
    </div>
</div>

<div class="form-group">
    <label for="tags" class="col-md-2 control-label">
        <g:message code="job.tags.label" default="tags"/>
    </label>

    <div class="col-md-10">
        <ul name="tags" id="tags">
            <g:each in="${job?.tags}">
                <li>${it}</li>
            </g:each>
        </ul>
    </div>
</div>

<g:each var="booleanAttribute" in="['option_isPrivate']">
    <g:render template="checkbox" model="${['booleanAttribute': booleanAttribute, 'job': job]}" />
</g:each>


<g:render template="/_common/modals/createJobGroupModal"/>