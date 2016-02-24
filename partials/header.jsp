<%@page pageEncoding="UTF-8" contentType="text/html" trimDirectiveWhitespaces="true"%>
<%@include file="../bundle/initialization.jspf" %>
<c:set var="broadcastAlerts" value="${Submissions.searchByForm(space.getKapp('helper').getForm('broadcast-alerts'), SubmissionHelper.broadcastAlertsQueryOptions())}"/>
<c:set var="pendingApprovals" value="${Submissions.searchByKapp(kapp, SubmissionHelper.approvalAlertsQueryOptions())}"/>
<header class="main-header">
    <!-- Logo -->
    <a href="${bundle.kappLocation}" class="logo">
        <!-- mini logo for sidebar mini 50x50 pixels -->
        <span class="logo-mini">
            <i class="fa fa-home"></i>
        </span>
        <!-- logo for regular state and mobile devices -->
        <span class="logo-lg">
            <c:if test="${not empty kapp.getAttribute('Company Logo')}">
              <c:choose>
                <c:when test ="${fn:containsIgnoreCase(kapp.getAttribute('Company Logo').value, 'http')}">
                  <img class="pull-left" src="${kapp.getAttribute('Company Logo').value}" alt="logo">
                </c:when>
                <c:otherwise>
                  <img class="pull-left" src="${bundle.location}/${kapp.getAttribute('Company Logo').value}" alt="logo">
                </c:otherwise>
              </c:choose>
            </c:if>
            <c:if test="${empty kapp.getAttribute('Company Logo')}">
                <i class="fa fa-home"></i> ${text.escape(kapp.name)}
            </c:if>
        </span>
    </a>

    <!-- Header Navbar: style can be found in header.less -->
    <nav class="navbar navbar-static-top" role="navigation">
      <!-- Sidebar toggle button-->
      <a href="#" class="sidebar-toggle" data-toggle="offcanvas" role="button">
        <span class="sr-only">Toggle navigation</span>
      </a>
      <!-- Navbar Right Menu -->
      <div class="navbar-custom-menu">
        <ul class="nav navbar-nav">
          <!-- Notifications: style can be found in dropdown.less -->
          <li class="dropdown messages-menu">
            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
              <i class="fa fa-bell-o"></i>
              <span class="label label-warning">${fn:length(broadcastAlerts)}</span>
            </a>
            <ul class="dropdown-menu">
              <li class="header">You have ${fn:length(broadcastAlerts)} notifications</li>
              <li>
                <!-- inner menu: contains the actual data -->
                <ul class="menu">
                  <c:forEach var="broadcastAlert" items="${broadcastAlerts}">
                    <li><!-- start message -->
                      <a href="#">
                        <div class="pull-left">
                          <i class="fa fa-warning text-yellow" alt="Alert"></i>
                        </div>
                        <h4>
                          ${broadcastAlert.getValue('Subject')}
                          <small>
                            <i class="fa fa-clock-o"></i>
                            <fmt:formatDate value="${broadcastAlert.createdAt}" timeStyle="short"/>
                          </small>
                        </h4>
                        <p>${broadcastAlert.getValue('Message')}</p>
                      </a>
                    </li><!-- end message -->
                  </c:forEach>
                </ul>
              </li>
              <li class="footer"><a href="#"></a></li>
            </ul>
          </li>
          <!-- Tasks: style can be found in dropdown.less -->
          <c:if test="${not empty pendingApprovals}">
            <li class="dropdown tasks-menu">
              <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                <i class="fa fa-thumbs-o-up"></i>
                <span class="label label-danger">${fn:length(pendingApprovals)}</span>
              </a>
              <ul class="dropdown-menu">
                <li class="header">You have ${fn:length(pendingApprovals)} Approvals Pending</li>
                <li>
                  <!-- inner menu: contains the actual data -->
                  <ul class="menu">
                    <c:forEach var="approval" items="${pendingApprovals}">
                      <li><!-- Task item -->
                        <a href="${bundle.spaceLocation}/submissions/${approval.id}">
                          <h3>
                            ${Submissions.retrieve(approval.getValue('Parent Instance ID')).form.name}
                          </h3>
                          <p>
                              <span>${approval.label}</span>
                          <p>
                        </a>
                      </li><!-- end task item -->
                    </c:forEach>
                  </ul>
                </li>
                <li class="footer">
                  <a href="${bundle.kappLocation}?page=submissions&type=approval">View all Approvals</a>
                </li>
              </ul>
            </li>
          </c:if>
          <!-- User Account: style can be found in dropdown.less -->
          <li class="dropdown user user-menu">
            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
              <i class="user-image fa fa-user fa-2x" alt="User Image"></i>
              <span class="hidden-xs">${text.escape(identity.user.displayName)}</span>
            </a>
            <ul class="dropdown-menu">
              <!-- User image -->
              <li class="user-header">
                <i class="fa fa-user fa-5x fa-inverse img-circle" alt="User Image"></i>
                <p>
                  ${text.escape(identity.user.displayName)}
                  <small>Member since Nov. 2012</small>
                </p>
              </li>
              <!-- Menu Footer-->
              <li class="user-footer">
                <div class="pull-left">
                  <a href="${bundle.spaceLocation}/${kapp.slug}?page=profile" class="btn btn-default btn-flat">Profile</a>
                </div>
                <div class="pull-right">
                  <a href="${bundle.spaceLocation}/app/logout" class="btn btn-default btn-flat">Sign out</a>
                </div>
              </li>
            </ul>
          </li>
        </ul>
      </div>
    </nav>
</header>
