var sparkmindapp = angular.module('sparkmindapp',['ngRoute', 'blogControllers','blogServices']);

sparkmindapp.config(['$routeProvider',function($routeProvider){
	$routeProvider.when('/myangular',{
		templateUrl:'abc.html',
		Controller:'blogController'
	}).when(
			'/myangular/:stories',{
				templateUrl:'xyz.html',
				Controller:'blogController'
			});
}]);

var blogControllers = angular.module('blogControllers', []);

blogControllers.controller('blogController', ['$scope', 'Blog',
  function($scope, Blog) {
    $scope.phones = Blog.query();
    $scope.orderProp = 'age';
  }]);

var blogServices = angular.module('blogServices', ['ngResource']);

blogServices.factory('Blog', ['$resource',
  function($resource){
    return $resource('phones/:phoneId.json', {}, {
      query: {method:'GET', params:{phoneId:'phones'}, isArray:true}
    });
  }]);

var utils={
		_url:' ',
		setup:function(u){
			this._url=u;
		},
		url:function(u){
			return this._url+u;
		},
		get:function(url,data,cb){
			$.ajax({
					type:'GET',
					url:url,
					cache:false,
					dataType:'json',
					contentType:'application/json; charset=utf-8',
					success:cb,
					error:function(){
						alert('error trying to retrieve ' + url);
					}
			});
		},
		
		 put:function (url, data, cb) {
		        var k = '_method',
		            v = 'PUT';
		        data[k] = v;
		        var headers = {};
		        headers[k] = v;
		        $.ajax({
		            type:'POST',
		            url:url,
		            cache:false,
		            headers:headers,
		            data:data,
		            success:function (result) {
		                cb(result);
		            },
		            error:function (e) {
		                console.log('error PUT\'ing to url ' + url + '. ' + JSON.stringify(e));
		            }
		        }); // todo

		    },
		    
		    post:function (u, data, cb) {
		        $.ajax({
		            type:'POST',
		            url:u,
		            cache:false,
		            dataType:'json',
		            data:data,
		            contentType:'application/json; charset=utf-8',
		            success:cb,
		            error:function () {
		                alert('error trying to post to ' + u);
		            }
		        });
		    }
};

function blogController($scope){
	$scope.users=[];
	
	$scope.query="anupam.p22@gmail.com";
	
	$scope.searchResultsFound = function(){
		return $scope.users !=null && $scope.users.length>0;
	};
	
	$scope.load = function(user){
		$scope.user=user;
		$scope.id=user.id;
	};
	
	$scope.search = function(){
		var u = utils.url('/search/user?q=' + $scope.query);
		//alert(u);
		utils.get(u, {}, function(users){
			$scope.$apply(function(){
				$scope.users=users;
				if ($scope.searchResultsFound()){
					if (users.length==1){
						$scope.load(users[0]);
					}
				}
			});
		});
	};
	
	$scope.isUserLoaded=function(){
		return $scope.user !=null && $scope.user.id !=null && $scope.user.id>0;
	};
	
	$scope.trash=function(){
		$scope.id=null;
		$scope.customer=null;
	};
	
	function loadUserById(id,cb){
		var u = utils.url('/users'+id);
		utils.get(u, {}, cb);
	};
	
	$scope.lookupUser = function(){
		loadUserById($scope.id, function(c){
			$scope.$apply(function(){
				$scope.load(c);
			});
		});
	};
	
	$scope.save = function(){
		var id= $scope.id;
		var data={firstName:$scope.user.firstName, lastName:$scope.user.lastName, email:$scope.user.email,id:$scope.user.id,role:$scope.user.role.role};
		
		function exists(o,p, cb){
			if (o[p] && o[p]!=null){
				cb(p,o[p]);
			}
		}
		exists($scope.user,'id',function(pName,val){
			data[pName]=val;
		});
		
		
		
		var idReceivingCallback = function(id){
			console.log('id is'+id);
			$scope.$apply(function(){
				$scope.id=id;
				$scope.lookupUser();
			});
		};
		var u= null;
		if (id!=null && id>0){
			u=utils.url('/users/'+id);
			console.log('sending the JSON'+JSON.stringify(data));
			utils.post(u,JSON.stringify(data),idReceivingCallback);
		}
		else{
			u=utils.url('/users/');
			utils.put(u,data,idReceivingCallback);
		}
	};
	
	
}

