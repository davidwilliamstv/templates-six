{if $sent}
    {include file="$template/includes/alert.tpl" type="success" msg=$LANG.contactsent textcenter=true}
{/if}

{if $errormessage}
    {include file="$template/includes/alert.tpl" type="error" errorshtml=$errormessage}
{/if}

{if !$sent}

	<div class="alert alert-info text-center">Please <a href="submitticket.php">login</a> before contacting us if you have an account.</div>

<form method="post" action="contact.php" class="form-horizontal" role="form">
        <input type="hidden" name="action" value="send" />

            <div class="form-group">
                <label for="inputName" class="col-sm-3 control-label">{$LANG.supportticketsclientname}</label>
                <div class="col-sm-7">
                    <input type="text" name="name" value="{$name}" class="form-control" id="inputName" />
                </div>
            </div>
            <div class="form-group">
                <label for="inputEmail" class="col-sm-3 control-label">{$LANG.supportticketsclientemail}</label>
                <div class="col-sm-7">
                    <input type="email" name="email" value="{$email}" class="form-control" id="inputEmail" />
                </div>
            </div>
            <div class="form-group">
                <label for="inputSubject" class="col-sm-3 control-label">{$LANG.supportticketsticketsubject}</label>
                <div class="col-sm-7">
                    <input type="subject" name="subject" value="{$subject}" class="form-control" id="inputSubject" />
                </div>
            </div>
            <div class="form-group">
                <label for="inputMessage" class="col-sm-3 control-label">{$LANG.contactmessage}</label>
                <div class="col-sm-7">
                    <textarea name="message" rows="7" class="form-control" id="inputMessage">{$message}</textarea>
                </div>
            </div>

            <div class="row">
                <div class="col-sm-offset-3 col-sm-9">
                    {include file="$template/includes/captcha.tpl"}
                </div>
            </div>

            <div class="form-group">
                <div class="text-center">
                    <button type="submit" class="btn btn-primary">{$LANG.contactsend}</button>
                </div>
            </div>

    </form>

{/if}
