<div class="form-group">
	<label for="chkbox-${booleanAttribute}" class="col-md-4 control-label">
		${label}
	</label>
	<div class="col-md-8">
		<div class="checkbox">
			<g:checkBox name="${booleanAttribute}" value="${job?."$booleanAttribute"}" id="chkbox-${booleanAttribute}"/>
		</div>
	</div>
</div>