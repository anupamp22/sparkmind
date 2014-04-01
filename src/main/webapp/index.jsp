<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:url value="/email/send" var="sendUrl"/>

<html>
<head>
	<meta http-equiv="content-type" content="text/html; charset=utf-8"/>
	<title>SparkMind Inc.</title>
	<link href= "resources/css/global.css" rel="stylesheet" type="text/css">
	 <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
	<script type="text/javascript" src="http://www.google.com/jsapi?key=AIzaSyBBA68G13-u82FGEMBFEx7VrSGzt7AvRE4"></script>
	<script src="http://www.google.com/uds/solutions/dynamicfeed/gfdynamicfeedcontrol.js" type="text/javascript"></script>
	<script type="text/javascript" src="resources/js/jquery.validate.min.js"></script>	
   	<script type="text/javascript" src="resources/js/script.js"></script>
   	<script type="text/javascript" src="resources/js/util.js"></script>
</head>

<body>
	<jsp:include page="WEB-INF/jsp/Header.jsp" />
	<div id="content">
		<!--<h1><b>About SparkMind </b>Inc.</h1> -->
		<div id ="Home">

		<h2>Home</h2>
		<p> SparkMind Technologies is a technology consulting services company specialized in the area of web application development and maintenance (ADM), system architecture and design, integration and support operating primarily using following technology stack: <b>Spring, Hibernate, Java, J2EE, jQuery, Ruby on Rails, MySql and Php.</b>
		In addition, we also do specialize in custom application development on Salesforce cloud using <b>Apex and Visualforce.</b>   
		</p>
		<p> 
		We specialize in open source technology stack with deep sense of architecture and design. We design and develop the applications with keen sense of performance and scalability.
		</p>
		<p>
		We bring extensive domain knowledge of financial services, eCommerce and blend them with our  deep software expertise to create innovative solutions.
		</p>
		<p>
		We believe that writing a software is both art and science. Software is not that something written once and for all. To write a good piece of code, one has to constantly strive for a good sense of design, keep refactoring the code and always think how the code can be scaled in large distributed multi-tiered environment with hundreds of thousands of users. Our unique value proposition is to bring expert design patterns, with highly modular and scalable algorithimic solutions.
		</p>
		<p>
		You can write to us, and avail our services. We help you with application development needs with above technology stack. Your satisfaction is what we strive for. If not satisfied, we will guarantee to pay you back with complete free services.
		</p>
		<p>
		</div>
		<div id="AboutUs">
			<div id="Company">
			<h2>Company</h2>
			<p>
				SparkMind Inc. is a technology consulting services company specialized in the area of application development and maintenance (ADM), system architecture and design, integration and support using following technology stack: <b>Spring, Hibernate, Java, J2EE, jQuery, Ruby on Rails, MySql and Php.</b> 
			</p>

			</div>

			<div id="Vision">
			<h2>Our Vision</h2>
			<p>
				Our vision is to build web and mobile applications and platforms using the open source stack.
			</p>

			</div>

			<div id ="Mission">
				<h2>Our Mission</h2>
				<p> SparkMind is committed to provide the innovative solutions using the open source technology stack to increase the operational efficiency and drive down the cost.	
				</p>			
			</div>
			<div id ="ManagementTeam">
				<h2>Management Team</h2>
				<p> Anupam Priyadarshi is the CEO and Founder of SparkMind Technologies Inc. He has extensive experience of Software development by implementing and deploying complex solutions for eCommerce and financial services industry.
				His deep technical skills along with extensive domain expertise is the key to success of SparkMind tech.	
				</p>			
			</div>
			<div id ="error">
				<h2>Error</h2>
				<p> This page is in construction. Please visit later.
				</p>			
			</div>
		</div>
		<!--  <div id="div_contact">
	 	<form id="form_contact" class="blocks">
		 		<p>
		 			<label>Name:</label>
		 			<input type="text" class="text1" name="name" id="name"/> 
		 		</p>
		 	
		 		<p>
		 			<label>Organization:</label>
		 			<input type="text" class="text1" name="company" id="company"/> 
		 		</p>
		 		<p>
		 			<label>Email:</label>
		 			<input type="text" class="text1" name="email" id="email"/> 
		 		</p>
		 		<p>
		 			<label>Contact number:</label>
		 			<input type="text" class="text1" name="phone" id="phone"/> 
		 		</p>
		 		<p>
		 			<label>Message:</label>
		 			<textarea class="textarea" name="message" id="message"> </textarea>
		 		</p>
		 		<p align="center">
		 			<input type="submit" class="button" value="Send" id="submit"/>
			 		<input type="reset" class="button" value="Reset" id="reset" />
		 		</p>
		 	</form>
	</div>-->
	
	<div id="feed1">
	</div>
	
	<div id="feed2">
		<p></p>
	</div>
	<div id="feed3">
		<p></p>
	</div>
	<div id="feed4">
		<p></p>
	</div>	
	<div id="searchResults">Loading the search results...</div>	
	</div>
	
	<div id="sidebar">
		<div id="search"></div>
		<!--  <form id="search" method="post">
			<input type="text" id="search_text" class="text"/>
			<input type="submit" value="Search"/>
		</form>-->
		<div id="news-feed">
			<h3>Tech Trend</h3>
			<h4>Latest in technology<br></h4>
			<p>
				Wanna read Gartner Reports?
			</p>
			<a href="http://www.gartner.com/newsroom/id/2603623"><img src="${pageContext.request.contextPath}/resources/image/data-analytics.jpg" alt="Gartner reports"></a>
		</div>
	
		<div id="post-archive">
			<h3>News feed</h3>
			<div id="feed5"> </div>
			<!--<table cellspacing="2">
				<caption>March 2014</caption>
				<thead>
					<tr>
					<th scope="col" class="sun">Sun</th>
					<th scope="col" class="mon">Mon</th>
					<th scope="col" class="tue">Tue</th>
					<th scope="col" class="wed">Wed</th>
					<th scope="col" class="thu">Thu</th>
					<th scope="col" class="fri">Fri</th>
					<th scope="col" class="sat">Sat</th>
					</tr>
				</thead>
				<tbody>
					<tr>
					<td class="sun"></td>
					<td class="mon"></td>
					<td class="tue"></td>
					<td class="wed"></td>
					<td class="thu"></td>
					<td class="fri"></td>
					<td class="sat">1</td>
					</tr>
					<tr>
					<td class="sun">2</td>
					<td class="mon">3</td>
					<td class="tue">4</td>
					<td class="wed">5</td>
					<td class="thu">6</td>
					<td class="fri"><a href="#">7</a></td>
					<td class="sat">8</td>
					</tr>
					<tr>
					<td class="sun">9</td>
					<td class="mon">10</td>
					<td class="tue"><a href="#">11</a></td>
					<td class="wed">12</td>
					<td class="thu">13</td>
					<td class="fri">14</td>
					<td class="sat">15</td>
					</tr>
					<tr>
					<td class="sun">16</td>
					<td class="mon">17</td>
					<td class="tue">18</td>
					<td class="wed">19</td>
					<td class="thu"><a href="#">20</a></td>
					<td class="fri"><a href="#">21</a></td>
					<td class="sat">22</td>
					</tr>
					<tr>
					<td class="sun">23</td>
					<td class="mon"><a href="#">24</a></td>
					<td class="tue">25</td>
					<td class="wed"><a href="#">26</a></td>
					<td class="thu">27</td>
					<td class="fri">28</td>
					<td class="sat">29</td>
					</tr>
					<tr>
					<td class="sun">30</td>
					<td class="mon">31</td>
					<td class="tue"></td>
					<td class="wed"></td>
					<td class="thu"></td>
					<td class="fri"></td>
					<td class="sat"></td>
					</tr>
				</tbody>
			</table> -->
		</div>
	</div>
	<div id='msgbox' title='' style='display:none'></div>
	<jsp:include page="WEB-INF/jsp/Footer.jsp" />
	<style type="text/css"> @import url("http://www.google.com/uds/solutions/dynamicfeed/gfdynamicfeedcontrol.css") </style>
</body>

</html>