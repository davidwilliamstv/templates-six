<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="{$charset}" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>{$companyname} - {if $kbarticle.title}{$kbarticle.title}{else}{$pagetitle}{/if}</title>

    {include file="$template/includes/head.tpl"}

    {$headoutput}

</head>
<body>

{$headeroutput}

<section id="header">
    <div class="container-fluid">

        <!-- Top Bar -->
        <div id="top-nav">
        <!-- Currency -->
        <div class="pull-right nav">
        <a href="#" class="quick-nav" data-toggle="popover" id="currencyChooser"><i class="fa fa-money"></i> {$LANG.choosecurrency} <span class="caret"></span></a>
        <div id="currencyChooserContent" class="hidden">
        <ul>
        {foreach from=$currencies item=curr}
        <li><a href="{$currentpagelinkback}currency={$curr.id}">{$curr.code}</a> <a href="{$currentpagelinkback}currency={$curr.id}"><img src="assets/img/flags/{if $curr.code eq "EUR"}eu{elseif $curr.code eq "GBP"}gb{elseif $curr.code eq "USD"}us{else}na{/if}.png" border="0" alt="" /></a></li>
         {/foreach}
         </ul>
         </div>
         </div>
            <!-- Language -->
            {if $languagechangeenabled && count($locales) > 1}
                <div class="pull-right nav">
                    <a href="#" class="quick-nav" data-toggle="popover" id="languageChooser"><i class="fa fa-language"></i> {$LANG.chooselanguage} <span class="caret"></span></a>
                    <div id="languageChooserContent" class="hidden">
                        <ul>
                            {foreach from=$locales item=locale}
                                <li><a href="{$currentpagelinkback}language={$locale.language}">{$locale.localisedName}</a></li>
                            {/foreach}
                        </ul>
                    </div>
                </div>
            {/if}
            <!-- Login/Account Notifications -->
            {if $loggedin}
                <div class="pull-right nav">
                    {if {$clientAlerts|count} > 0}<a href="#" class="quick-nav-alert" data-toggle="popover" id="accountNotifications" data-placement="bottom" title="{lang key="notifications"}"><i class="fa fa-info"></i> {$LANG.notifications} ({$clientAlerts|count})</a>
                    <div id="accountNotificationsContent" class="hidden">
                        {foreach $clientAlerts as $alert}
                            <div class="clientalert text-{$alert->getSeverity()}">{$alert->getMessage()}{if $alert->getLinkText()} <a href="{$alert->getLink()}" class="btn btn-xs btn-{$alert->getSeverity()}">{$alert->getLinkText()}</a>{/if}</div>
                        {foreachelse}
                            <div class="clientalert text-success"><i class="fa fa-check-square-o"></i> {$LANG.notificationsnone}</div>
                        {/foreach}
                    </div>
                    {else}
                    <a href="#" class="quick-nav" data-toggle="popover" id="accountNotifications" data-placement="bottom" title="{lang key="notifications"}"><i class="fa fa-info"></i> {$LANG.notifications} ({$clientAlerts|count})</a>
                    <div id="accountNotificationsContent" class="hidden">
                        {foreach $clientAlerts as $alert}
                            <div class="clientalert text-{$alert->getSeverity()}">{$alert->getMessage()}{if $alert->getLinkText()} <a href="{$alert->getLink()}" class="btn btn-xs btn-{$alert->getSeverity()}">{$alert->getLinkText()}</a>{/if}</div>
                        {foreachelse}
                            <div class="clientalert text-success"><i class="fa fa-check-square-o"></i> {$LANG.notificationsnone}</div>
                        {/foreach}
                    </div>{/if}
                </div>
            {else}
                <div class="pull-right nav">
                    <a href="#" class="quick-nav" data-toggle="popover" id="loginOrRegister" data-placement="bottom"><i class="fa fa-user"></i> {$LANG.login}</a>
                    <div id="loginOrRegisterContent" class="hidden">
                        <form action="dologin.php" method="post" role="form">
                            <div class="form-group">
                                <input type="email" name="username" class="form-control" placeholder="{$LANG.clientareaemail}" required />
                            </div>
                            <div class="form-group">
                                <div class="input-group">
                                    <input type="password" name="password" class="form-control" placeholder="{$LANG.loginpassword}" required />
                                    <span class="input-group-btn">
                                        <input type="submit" class="btn btn-primary" value="{$LANG.login}" />
                                    </span>
                                </div>
                            </div>
                            <label class="checkbox-inline">
                                <input type="checkbox" name="rememberme" /> {$LANG.loginrememberme} &bull; <a href="pwreset.php">{$LANG.forgotpw}</a>
                            </label>
                        </form>
                        {if $condlinks.allowClientRegistration}
                            <hr />
                            {$LANG.newcustomersignup|sprintf2:'<a href="register.php">':'</a>'}
                        {/if}
                    </div>
                </div>
            {/if}
            <!-- Shopping Cart -->
            <div class="pull-right nav">
                <a href="cart.php?a=view" class="quick-nav"><i class="fa fa-shopping-cart"></i> <span class="hidden-xs">{$LANG.viewcart} (</span><span id="cartItemCount">{$cartitemcount}</span><span class="hidden-xs">)</span></a>
            </div>

            {if $adminMasqueradingAsClient}
                <!-- Return to admin link -->
                <div class="alert alert-danger admin-masquerade-notice">
                    {$LANG.adminmasqueradingasclient}<br />
                    <a href="logout.php?returntoadmin=1" class="alert-link">{$LANG.logoutandreturntoadminarea}</a>
                </div>
            {elseif $adminLoggedIn}
                <!-- Return to admin link -->
                <div class="alert alert-danger admin-masquerade-notice">
                    {$LANG.adminloggedin}<br />
                    <a href="logout.php?returntoadmin=1" class="alert-link">{$LANG.returntoadminarea}</a>
                </div>
            {/if}

        </div>

        <a href="index.php"><img src="{$WEB_ROOT}/templates/{$template}/img/logo.png" alt="{$companyname}" /></a>

    </div>
</section>

<section id="main-menu">

    <nav id="nav" class="navbar navbar-default navbar-main" role="navigation">
        <div class="container-fluid">
            <!-- Brand and toggle get grouped for better mobile display -->
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
            </div>

            <!-- Collect the nav links, forms, and other content for toggling -->
            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">

                <ul class="nav navbar-nav">
                
                    <li><a href="/index.php"><i class="fa fa-home fa-fw"></i> {$LANG.hometitle}</a></li>
                    <li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" href="#"><i class="fa fa-hdd-o fa-fw"></i> {$LANG.hosting}&nbsp;<b class="caret"></b></a>
                    	<ul class="dropdown-menu">
                       		<li><a href="/hosting.php">cPanel Hosting</a></li>
                       		<li><a href="/resellerhosting.php">WHM Reseller Hosting</a></li>
                        	<li><a href="/network.php">Our Network</a></li>
                        </ul>
                    </li>
                    <li><a href="/domainchecker.php"><i class="fa fa-globe fa-fw"></i> {$LANG.navdomains}</a></li>
                    <li><a href="/ssl.php"><i class="fa fa-lock fa-fw"></i> SSL</a></li>
                    <li><a href="/design.php"><i class="fa fa-paint-brush fa-fw"></i> Design</a></li>
                    <li><a href="/announcements.php"><i class="fa fa-pencil-square-o fa-fw"></i> {$LANG.announcementstitle}</a></li>
                    <li>{if $loggedin}<a href="/affiliates.php">{else}<a href="/affiliate.php">{/if}<i class="fa fa-users fa-fw"></i> Affiliate</a></li>
                    

                </ul>

                <ul class="nav navbar-nav navbar-right">

                    <li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" href="#"><i class="fa fa-support fa-fw"></i> {$LANG.navsupport}&nbsp;<b class="caret"></b></a>
                    	<ul class="dropdown-menu">
                      		<li>{if $loggedin}<a href="/submitticket.php">{$LANG.navopenticket}</a>{else}<a href="contact.php">{$LANG.contactus}</a>{/if}</li>
                            {if $loggedin}<li><a href="/supporttickets.php">{$LANG.navtickets}</a></li>{/if}
                      		<li><a href="/knowledgebase.php">{$LANG.knowledgebasetitle}</a></li>
                      		<li><a href="/serverstatus.php">{$LANG.networkstatustitle}</a></li>
            			</ul>
                  	</li>
                    <li class="dropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="fa fa-user fa-fw"></i> {if $loggedin}{$loggedinuser.firstname}{else}{$LANG.account}{/if}&nbsp;<b class="caret"></b></a>
                      	<ul class="dropdown-menu">
                        {if $loggedin}
                        	<li><a href="/clientarea.php">{$LANG.clientareatitle}</a></li>
                        	<li class="divider"></li>
                            <li><a href="/clientarea.php?action=details">{$LANG.editaccountdetails}</a></li>
                            <li><a href="/clientarea.php?action=contacts">{$LANG.clientareanavcontacts}</a></li>
                            <li><a href="/clientarea.php?action=changepw">{$LANG.clientareanavchangepw}</a></li>
                            <li><a href="/clientarea.php?action=emails">{$LANG.navemailssent}</a></li>
                            <li class="divider"></li>
                            <li><a href="/clientarea.php?action=services">{$LANG.clientareanavservices}</a></li>
                            <li><a href="/clientarea.php?action=domains">{$LANG.clientareanavdomains}</a></li>
                            <li class="divider"></li>
                            <li><a href="/clientarea.php?action=invoices">{$LANG.invoices}</a></li>
                            <li><a href="/clientarea.php?action=quotes">{$LANG.quotestitle}</a></li>
                            <li><a href="/clientarea.php?action=creditcard">{$LANG.clientareanavccdetails}</a></li>
                            <li class="divider"></li>
                            <li><a href="/logout.php">{$LANG.logouttitle}</a></li>
                        {else}
                            <li><a href="/clientarea.php">{$LANG.login}</a></li>
							<li><a href="/register.php">{$LANG.register}</a></li>
                      	{/if}
                        </ul>
                    </li>
                </ul>

            </div><!-- /.navbar-collapse -->
        </div>
    </nav>

</section>

{if $templatefile == 'homepage'}
    <script type="text/javascript" src="/templates/aah/js/jssor.slider.mini.js"></script>
<script>
        jQuery(document).ready(function ($) {
            var options = {
                $AutoPlay: true,                                    //[Optional] Whether to auto play, to enable slideshow, this option must be set to true, default value is false
                $AutoPlaySteps: 1,                                  //[Optional] Steps to go for each navigation request (this options applys only when slideshow disabled), the default value is 1
                $AutoPlayInterval: 0,                            //[Optional] Interval (in milliseconds) to go for next slide since the previous stopped if the slider is auto playing, default value is 3000
                $PauseOnHover: 4,                               //[Optional] Whether to pause when mouse over if a slider is auto playing, 0 no pause, 1 pause for desktop, 2 pause for touch device, 3 pause for desktop and touch device, 4 freeze for desktop, 8 freeze for touch device, 12 freeze for desktop and touch device, default value is 1

                $ArrowKeyNavigation: false,   			            //[Optional] Allows keyboard (arrow key) navigation or not, default value is false
                $SlideEasing: $JssorEasing$.$EaseLinear,          //[Optional] Specifies easing for right to left animation, default value is $JssorEasing$.$EaseOutQuad
                $SlideDuration: 5000,                                //[Optional] Specifies default duration (swipe) for slide in milliseconds, default value is 500
                $MinDragOffsetToSlide: 20,                          //[Optional] Minimum drag offset to trigger slide , default value is 20
                $SlideWidth: 130,                                   //[Optional] Width of every slide in pixels, default value is width of 'slides' container
                //$SlideHeight: 100,                                //[Optional] Height of every slide in pixels, default value is height of 'slides' container
                $SlideSpacing: 10, 					                //[Optional] Space between each slide in pixels, default value is 0
                $DisplayPieces: 15,                                  //[Optional] Number of pieces to display (the slideshow would be disabled if the value is set to greater than 1), the default value is 1
                $ParkingPosition: 0,                              //[Optional] The offset position to park slide (this options applys only when slideshow disabled), default value is 0.
                $UISearchMode: 1,                                   //[Optional] The way (0 parellel, 1 recursive, default value is 1) to search UI components (slides container, loading screen, navigator container, arrow navigator container, thumbnail navigator container etc).
                $PlayOrientation: 1,                                //[Optional] Orientation to play slide (for auto play, navigation), 1 horizental, 2 vertical, 5 horizental reverse, 6 vertical reverse, default value is 1
                $DragOrientation: 1                                //[Optional] Orientation to drag slide, 0 no drag, 1 horizental, 2 vertical, 3 either, default value is 1 (Note that the $DragOrientation should be the same as $PlayOrientation when $DisplayPieces is greater than 1, or parking position is not 0)
            };

            var jssor_slider1 = new $JssorSlider$("slider1_container", options);
        });
    </script>
    <section id="home-banner">
        <div class="row text-center">
            {if $registerdomainenabled}
                <h2>{$LANG.homebegin}</h2>
                <form method="post" action="domainchecker.php">
                    <div class="container">
                        <div class="col-md-8 col-md-offset-2 col-sm-10 col-sm-offset-1">
                            <div class="input-group input-group-lg">
                                <input type="text" class="form-control" name="domain" placeholder="{$LANG.exampledomain}" />
                                <span class="input-group-btn">
                                    <input type="submit" class="btn btn-warning" value="Search" />
                                </span>
                            </div>
                        </div>
                    </div>

                    {include file="$template/includes/captcha.tpl"}
                </form>
                <!-- Jssor Slider Begin --> 
  <!-- To move inline styles to css file/block, please specify a class name for each element. -->
  <div id="slider1_container" style="position: relative; top: 20px; left: 0px; height: 130px; overflow: hidden;"> 
    
    <!-- Slides Container -->
    <div u="slides" style="cursor: move; position: absolute; left: 0px; top: 0px; width: 100%; height: 130px; overflow: hidden;">
      <div><a u="image" href="cart.php?a=add&domain=register&tld=.asia"><img src="templates/aah/img/asia.png" /></a></div>
      <div><a u="image" href="cart.php?a=add&domain=register&tld=.au"><img src="templates/aah/img/au.png" /></a></div>
      <div><a u="image" href="cart.php?a=add&domain=register&tld=.biz"><img src="templates/aah/img/biz.png" /></a></div>
      <div><a u="image" href="cart.php?a=add&domain=register&tld=.bz"><img src="templates/aah/img/bz.png" /></a></div>
      <div><a u="image" href="cart.php?a=add&domain=register&tld=.ca"><img src="templates/aah/img/ca.png" /></a></div>
      <div><a u="image" href="cart.php?a=add&domain=register&tld=.cc"><img src="templates/aah/img/cc.png" /></a></div>
      <div><a u="image" href="cart.php?a=add&domain=register&tld=.cn"><img src="templates/aah/img/cn.png" /></a></div>
      <div><a u="image" href="cart.php?a=add&domain=register&tld=.co"><img src="templates/aah/img/co.png" /></a></div>
      <div><a u="image" href="cart.php?a=add&domain=register&tld=.com"><img src="templates/aah/img/com.png" /></a></div>
      <div><a u="image" href="cart.php?a=add&domain=register&tld=.de"><img src="templates/aah/img/de.png" /></a></div>
      <div><a u="image" href="cart.php?a=add&domain=register&tld=.es"><img src="templates/aah/img/es.png" /></a></div>
      <div><a u="image" href="cart.php?a=add&domain=register&tld=.eu"><img src="templates/aah/img/eu.png" /></a></div>
      <div><a u="image" href="cart.php?a=add&domain=register&tld=.in"><img src="templates/aah/img/in.png" /></a></div>
      <div><a u="image" href="cart.php?a=add&domain=register&tld=.info"><img src="templates/aah/img/info.png" /></a></div>
      <div><a u="image" href="cart.php?a=add&domain=register&tld=.me"><img src="templates/aah/img/me.png" /></a></div>
      <div><a u="image" href="cart.php?a=add&domain=register&tld=.mobi"><img src="templates/aah/img/mobi.png" /></a></div>
      <div><a u="image" href="cart.php?a=add&domain=register&tld=.name"><img src="templates/aah/img/name.png" /></a></div>
      <div><a u="image" href="cart.php?a=add&domain=register&tld=.net"><img src="templates/aah/img/net.png" /></a></div>
      <div><a u="image" href="cart.php?a=add&domain=register&tld=.nl"><img src="templates/aah/img/nl.png" /></a></div>
      <div><a u="image" href="cart.php?a=add&domain=register&tld=.nz"><img src="templates/aah/img/nz.png" /></a></div>
      <div><a u="image" href="cart.php?a=add&domain=register&tld=.org"><img src="templates/aah/img/org.png" /></a></div>
      <div><a u="image" href="cart.php?a=add&domain=register&tld=.ru"><img src="templates/aah/img/ru.png" /></a></div>
      <div><a u="image" href="cart.php?a=add&domain=register&tld=.tel"><img src="templates/aah/img/tel.png" /></a></div>
      <div><a u="image" href="cart.php?a=add&domain=register&tld=.tv"><img src="templates/aah/img/tv.png" /></a></div>
      <div><a u="image" href="cart.php?a=add&domain=register&tld=.uk"><img src="templates/aah/img/uk.png" /></a></div>
      <div><a u="image" href="cart.php?a=add&domain=register&tld=.co.uk"><img src="templates/aah/img/co-uk.png" /></a></div>
      <div><a u="image" href="cart.php?a=add&domain=register&tld=.me.uk"><img src="templates/aah/img/me-uk.png" /></a></div>
      <div><a u="image" href="cart.php?a=add&domain=register&tld=.org.uk"><img src="templates/aah/img/org-uk.png" /></a></div>
      <div><a u="image" href="cart.php?a=add&domain=register&tld=.us"><img src="templates/aah/img/us.png" /></a></div>
      <div><a u="image" href="cart.php?a=add&domain=register&tld=.ws"><img src="templates/aah/img/ws.png" /></a></div>
    </div>
  </div>
  <!-- Jssor Slider End -->
            {else}
                <h2>{$LANG.doToday}</h2>
            {/if}
        </div>
    </section>
    <div class="home-shortcuts">
        <div class="container">
            <div class="row">
                <div class="col-md-4 hidden-sm hidden-xs text-center">
                    <p class="lead">
                        {$LANG.howcanwehelp}
                    </p>
                </div>
                <div class="col-sm-12 col-md-8">
                    <ul>
                    {if $registerdomainenabled || $transferdomainenabled}
                        <li>
                            <a id="btnBuyADomain" href="domainchecker.php">
                                <i class="fa fa-globe"></i>
                                <p>
                                    {$LANG.buyadomain} <span>&raquo;</span>
                                </p>
                            </a>
                        </li>
                     {/if}
                        <li>
                            <a id="btnOrderHosting" href="cart.php">
                                <i class="fa fa-hdd-o"></i>
                                <p>
                                    {$LANG.orderhosting} <span>&raquo;</span>
                                </p>
                            </a>
                        </li>
                        <li>
                            <a id="btnMakePayment" href="clientarea.php">
                                <i class="fa fa-credit-card"></i>
                                <p>
                                    {$LANG.makepayment} <span>&raquo;</span>
                                </p>
                            </a>
                        </li>
                        <li>
                            <a id="btnGetSupport" href="submitticket.php">
                                <i class="fa fa-envelope-o"></i>
                                <p>
                                    {$LANG.getsupport} <span>&raquo;</span>
                                </p>
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
{/if}

<section id="main-body" class="container">

    <div class="row">
        {if !$inShoppingCart && ($primarySidebar->hasChildren() || $secondarySidebar->hasChildren())}
            {if $primarySidebar->hasChildren()}
                <div class="col-md-9 pull-md-right">
                    {include file="$template/includes/pageheader.tpl" title=$displayTitle desc=$tagline showbreadcrumb=false}
                </div>
            {/if}
            <div class="col-md-3 pull-md-left sidebar">
                {include file="$template/includes/sidebar.tpl" sidebar=$primarySidebar}
            </div>
        {/if}
        <!-- Container for main page display content -->
        <div class="{if !$inShoppingCart && ($primarySidebar->hasChildren() || $secondarySidebar->hasChildren())}col-md-9 pull-md-right{else}col-xs-12{/if} main-content">
            {if !$primarySidebar->hasChildren() && !$showingLoginPage && $templatefile != 'homepage'}
                {include file="$template/includes/pageheader.tpl" title=$displayTitle desc=$tagline showbreadcrumb=false}
            {/if}
        {if $SCRIPT_NAME == "/clientarea.php" || $SCRIPT_NAME == "/knowledgebase.php"}<div class="header-lined">{include file="$template/includes/breadcrumb.tpl"}</div>{/if}
