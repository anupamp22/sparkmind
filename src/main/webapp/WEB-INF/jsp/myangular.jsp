<!DOCTYPE html>

<html data-ng-app>
	<head>
		<title>My Messages</title>
		<jsp:include page="common/BootstrapWithWebJar.jsp"></jsp:include>
		<script type="text/javascript">
		    $(function() {
		    	utils.setup('${pageContext.request.contextPath}');
		    });
		</script>
	</head>
	
	<body>
		<div class="container">
				<jsp:include page="common/Header.jsp" />
				<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>			
				<div data-ng-controller="blogController">
							
								<div class="row">
									 <!--<div class="span3">
										<ul class="nav nav-pills nav-stacked">
						                    <li><a href="${pageContext.request.contextPath}">Home</a></li>
						                    <li><a href="${pageContext.request.contextPath}">About Us</a></li>
						                    <li><a href="${pageContext.request.contextPath}">Company</a></li>
						                    <li><a href="${pageContext.request.contextPath}">Product and Services</a></li>
						                    <li><a href="${pageContext.request.contextPath}">Our Team</a></li>
						                    <li><a href="${pageContext.request.contextPath}">Contact Us</a></li>
								        </ul> 
									</div>-->
										<div class="span3">
											<input type="text" id="search" class="input-medium search-query" data-ng-model="query"/>
						               		<a href="#" class="icon-search" data-ng-click="search()"></a>
											  Sort by:
											      <select data-ng-model="orderProp">
											        <option value="name">Alphabetical</option>
											        <option value="age">Newest</option>
											      </select>
										</div>
										
										<div class="span3">
						                    <div data-ng-show="!searchResultsFound()">
						                        <span class="no-records">(no results)</span>
						                    </div>
						                   <div data-ng-show=" searchResultsFound()">
						                   		<ul>	
						                        <li data-ng-repeat="user in users | filter:query | orderBy:orderProp" class="search-results">
						                            <span class="title">
						                                <span style="font-size: smaller"><span>#</span>{{user.id}}</span>
						                                <a data-ng-click="load(user)">{{user.firstName}} {{user.lastName}}</a> </span>
						                        </li>
						                      </ul>	
						                    </div>
										</div>
										<div class="span6">
										 <fieldset>
											 <legend>
											     <span class="user-visible-{{!isUserLoaded()}}"> Create New User </span>
											     <span class="user-visible-{{isUserLoaded()}}"> Update {{user.firstName}} {{user.lastName}} - {{user.id}} </span>
											 </legend>									 	
											<div class="control-group">
								                <label class="control-label" for="fn">First Name:</label>
								                <div class="controls">
								                    <input class="input-xlarge" id="fn" type="text" data-ng-model="user.firstName"
								                           placeholder="first name" required="required"/>
								                    <p class="help-block">Change the first name</p>
								                </div>
								            </div>
								            <div class="control-group">
								                <label class="control-label" for="ln">Last Name:</label>
								                <div class="controls">
								                    <input class="input-xlarge" id="ln" type="text" data-ng-model="user.lastName" placeholder="last name"
								                           required="required"/>
								                    <p class="help-block">Change the last name</p>
								                </div>
								            </div>
								            <div class="form-actions">
								                <button type="submit" class="btn btn-primary" data-ng-click="save()" data-ng-model-instant>
								                    <a class="icon-plus"></a> Save
								                </button>
								                <button class="btn " data-ng-click="trash()"><a class="icon-trash"></a> Cancel</button>
								            </div>
								            </fieldset>
								   	</div>
										
									</div>
								
								
								
									<div class="row"> 
										
									</div>
								

					</div>
				<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>
				<jsp:include page="common/Footer.jsp" />
		</div>
	</body>
</html>