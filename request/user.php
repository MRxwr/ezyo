<?php
if ( isset($_GET["type"]) && !empty($_GET["type"]) ){
	if( $_GET["type"] == "login" ){
		if ( !isset($_POST["email"]) || empty($_POST["email"]) ){
			$error = array("msg"=>"Please enter email correctly.");
			if ( isset($_GET["lang"]) && $_GET["lang"] == "ar" ){
				$error = array("msg"=>"الرجاء إدخال البريد الإلكتروني بالشكل الصحيح");
			}
			echo outputError($error);die();
		}
		if ( !isset($_POST["password"]) || empty($_POST["password"]) ){
			$error = array("msg"=>"Please enter password correctly.");
			if ( isset($_GET["lang"]) && $_GET["lang"] == "ar" ){
				$error = array("msg"=>"الرجاء إدخال كلمة المرور بشكل صحيح");
			}
			echo outputError($error);die();
		}
		if($user = selectDB('customers',"`email` LIKE '".$_POST["email"]."' AND `password` LIKE '".sha1($_POST["password"])."'")){
			if( $user[0]["status"] == 1 ){
				$error = array("msg"=>"Your account has been blocked. Please aconatct administration.");
				if ( isset($_GET["lang"]) && $_GET["lang"] == "ar" ){
					$error = array("msg"=>"حسابك تم إيقافه الرجاء التواصل مع الإدارة");
				}
				echo outputError($error);die();
			}elseif( $user[0]["status"] == 2 ){
				$error = array("msg"=>"Please enter user credintial correctly.");
				if ( isset($_GET["lang"]) && $_GET["lang"] == "ar" ){
					$error = array("msg"=>"الرجاء إدخال معلومات تسجيل الدخول بالشكل الصحيح");
				}
				echo outputError($error);die();
			}
			if ( isset($_POST["deviceToken"]) && !empty($_POST["deviceToken"]) ){
				if ($firebase = selectDB('firebase',"`customerId` LIKE '{$user[0]["id"]}'") ){
					$data = array(
						"deviceToken"=>$_POST["deviceToken"]
					);
					updateDB('firebase',$data," `customerId` LIKE '{$user[0]["id"]}'");
				}else{
					$data = array(
						"customerId"=>$user[0]["id"],
						"deviceToken"=>$_POST["deviceToken"]
					);
					insertDB('firebase',$data);
				}
			}
			echo outputData(array('id'=>$user[0]["id"]));
		}else{
			$error = array("msg"=>"Please enter user credintial correctly.");
			if ( isset($_GET["lang"]) && $_GET["lang"] == "ar" ){
				$error = array("msg"=>"الرجاء إدخال معلومات تسجيل الدخول بالشكل الصحيح");
			}
			echo outputError($error);die();
		}
	}elseif( $_GET["type"] == "social" ){
		if ( !isset($_POST["token"]) || empty($_POST["token"]) ){
			$error = array("msg"=>"Please enter social token");
			echo outputError($error);die();
		}
		if($user = selectDB('customers',"`token` LIKE '".$_POST["token"]."' ")){
			if( $user[0]["status"] == 1 ){
				$error = array("msg"=>"Your account has been blocked. Please aconatct administration.");
				if ( isset($_GET["lang"]) && $_GET["lang"] == "ar" ){
					$error = array("msg"=>"حسابك تم إيقافه الرجاء التواصل مع الإدارة");
				}
				echo outputError($error);die();
			}
			if ( isset($_POST["deviceToken"]) && !empty($_POST["deviceToken"]) ){
				if ($firebase = selectDB('firebase',"`customerId` LIKE '{$user[0]["id"]}'") ){
					$data = array(
						"deviceToken"=>$_POST["deviceToken"]
					);
					updateDB('firebase',$data," `customerId` LIKE '{$user[0]["id"]}'");
				}else{
					$data = array(
						"customerId"=>$user[0]["id"],
						"deviceToken"=>$_POST["deviceToken"]
					);
					insertDB('firebase',$data);
				}
			}
			echo outputData(array('id'=>$user[0]["id"]));
		}else{
			$error = array("msg"=>"Please enter user social token correctly.");
			echo outputError($error);die();
		}
	}elseif( $_GET["type"] == "forgetPassword" ){
		if ( !isset($_POST["email"]) || empty($_POST["email"]) ){
			$error = array("msg"=>"Please fill email");
			if ( isset($_GET["lang"]) && $_GET["lang"] == "ar" ){
				$error = array("msg"=>"الرجاء إدخال البريد الإلكتروني");
			}
			echo outputError($error);die();
		}
		if( selectDB('customers',"`email` LIKE '".$_POST["email"]."'") ){
			$random = rand(11111111,99999999);
			$data = array(
					"password"=>sha1($random)
			);
			updateDB('customers',$data," `email` LIKE '{$_POST["email"]}'");
			$curl = curl_init();
			curl_setopt_array($curl, array(
			  CURLOPT_URL => 'https://createid.link/api/v1/send/notify',
			  CURLOPT_RETURNTRANSFER => true,
			  CURLOPT_ENCODING => '',
			  CURLOPT_MAXREDIRS => 10,
			  CURLOPT_TIMEOUT => 0,
			  CURLOPT_FOLLOWLOCATION => true,
			  CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
			  CURLOPT_CUSTOMREQUEST => 'POST',
			  CURLOPT_POSTFIELDS => array(
				'site' => '- EZYO',
				'subject' => 'New Password',
				'body' => 'Your new password is: '.$random.'<br><br>(Note: Please change your passowrd as soon as you login in app.)',
				'from_email' => 'noreply@ezyokw.com',
				'to_email' => $_POST["email"]),
			));
			$response = curl_exec($curl);
			curl_close($curl);
			if ( isset($_GET["lang"]) && $_GET["lang"] == "ar" ){
				echo outputData(array('msg'=>"لقد تم إرسال كلمة مرور جديدة لبريدك الإلكتروني"));
			}else{
				echo outputData(array('msg'=>"A new password has been sent to your email."));
			}
			
		}else{
			$error = array("msg"=>"This email is not registred on our app, please enter a correct one.");
			if ( isset($_GET["lang"]) && $_GET["lang"] == "ar" ){
				$error = array("msg"=>"هذا البريد الإلكتروني غير مسجل لدينا، الرجاء إدخال البريد الإلكتروني بالشكل الصحيح");
			}
			echo outputError($error);die();
		}
	}elseif( $_GET["type"] == "register" ){
		if ( !isset($_POST["name"]) || empty($_POST["name"]) ){
			$error = array("msg"=>"Please enter name");
			if ( isset($_GET["lang"]) && $_GET["lang"] == "ar" ){
				$error = array("msg"=>"الرجاء إدخال الإسم");
			}
			echo outputError($error);die();
		}
		if ( !isset($_POST["email"]) || empty($_POST["email"]) ){
			$error = array("msg"=>"Please fill email");
			if ( isset($_GET["lang"]) && $_GET["lang"] == "ar" ){
				$error = array("msg"=>"الرجاء إدخال البريد الإلكتروني");
			}
			echo outputError($error);die();
		}
		if ( !isset($_POST["password"]) || empty($_POST["password"]) ){
			$error = array("msg"=>"Please fill password");
			if ( isset($_GET["lang"]) && $_GET["lang"] == "ar" ){
				$error = array("msg"=>"الرجاء إدخال كلمة المرور");
			}
			echo outputError($error);die();
		}
		if ( !isset($_POST["confirmPassword"]) || empty($_POST["confirmPassword"]) ){
			$error = array("msg"=>"Please fill confirm password");
			if ( isset($_GET["lang"]) && $_GET["lang"] == "ar" ){
				$error = array("msg"=>"الرجاء إدخال تأكيد كلمة المرور");
			}
			echo outputError($error);die();
		}
		if ( $_POST["password"] != $_POST["confirmPassword"] ){
			$error = array("msg"=>"Passwords does not match. Please try again.");
			if ( isset($_GET["lang"]) && $_GET["lang"] == "ar" ){
				$error = array("msg"=>"الرجاء التأكد من إدخال كلمة المرور و تأكيدها بالشكل الصحيح");
			}
			echo outputError($error);die();
		}
		/*
		type 
		0 register,
		1 social,
		2 guest
		*/	
		$_GET["type"] = $_POST["userType"];	
		$_POST["password"] = sha1($_POST["password"]);
		$deviceToken = $_POST["deviceToken"];
		unset($_POST["confirmPassword"]);
		unset($_POST["action"]);
		unset($_POST["userType"]);
		unset($_POST["deviceToken"]);
		$data = $_POST;
		if( selectDB('customers',"`email` LIKE '".$_POST["email"]."' AND `status` = '1' ") ){
			$error = array("msg"=>"A user with this email is already registred.");
			if ( isset($_GET["lang"]) && $_GET["lang"] == "ar" ){
				$error = array("msg"=>"هذا البريد الإلكتروني مسجل لدينا سابقا");
			}
			echo outputError($error);die();
		}
		
		if( insertDB('customers',$data) ){
			if ( $user = selectDB('customers',"`email` LIKE '".$_POST["email"]."' AND `password` LIKE '".$_POST["password"]."'") ){
				if( $user[0]["status"] == 1 ){
					$error = array("msg"=>"Your account has been blocked. Please aconatct administration.");
					if ( isset($_GET["lang"]) && $_GET["lang"] == "ar" ){
						$error = array("msg"=>"حسابك تم إيقافه الرجاء التواصل مع الإدارة");
					}
					echo outputError($error);die();
				}
				echo outputData(array('id'=>$user[0]["id"]));
				if ( isset($deviceToken) && !empty($deviceToken ) ){
					if ($firebase = selectDB('firebase',"`customerId` LIKE '{$user[0]["id"]}'") ){
						$data = array(
							"deviceToken"=>$deviceToken 
						);
						updateDB('firebase',$data," `customerId` LIKE '{$user[0]["id"]}'");
					}else{
						$data = array(
							"customerId"=>$user[0]["id"],
							"deviceToken"=>$deviceToken 
						);
						insertDB('firebase',$data);
					}
				}
			}
		}else{
			$error = array("msg"=>"Please enter registration data correctly.");
			if ( isset($_GET["lang"]) && $_GET["lang"] == "ar" ){
				$error = array("msg"=>"الرجاء إدخال معلومات تسجيل صحيحة");
			}
			echo outputError($error);die();
		}
	}elseif( $_GET["type"] == "guest" ){
		jump:
		$name = "guest_".rand(1111111,9999999);
		if ( selectDB('customers',"`name` LIKE '".$name."'") ){
			goto jump;
		}
		$data["email"] = $name . "@ezyoguest.com";
		$data["name"] = $name;
		$data["password"] = sha1("EZYo123");
		$data["type"] = 3;
		$data["guest"] = 1;
		if( insertDB('customers',$data) ){
			if ( $user = selectDB('customers',"`email` LIKE '".$data["email"]."' AND `password` LIKE '".sha1('EZYo123')."'") ){
				echo outputData(array('id'=>(STRING)$user[0]["id"]));
			}
			if ( isset($_POST["deviceToken"]) && !empty($_POST["deviceToken"]) ){
				if ($firebase = selectDB('firebase',"`customerId` LIKE '{$user[0]["id"]}'") ){
					$data = array(
						"deviceToken"=>$_POST["deviceToken"]
					);
					updateDB('firebase',$data," `customerId` LIKE '{$user[0]["id"]}'");
				}else{
					$data = array(
						"customerId"=>$user[0]["id"],
						"deviceToken"=>$_POST["deviceToken"]
					);
					insertDB('firebase',$data);
				}
			}
		}else{
			$error = array("msg"=>"Please enter registration data correctly.");
			if ( isset($_GET["lang"]) && $_GET["lang"] == "ar" ){
				$error = array("msg"=>"الرجاء إدخال معلومات تسجيل صحيحة");
			}
			echo outputError($error);die();
		}
	}elseif( $_GET["type"] == "remove" ){
		if ( !isset($_POST["userId"]) || empty($_POST["userId"]) ){
			$error = array("msg"=>"Please enter user id");
			if ( isset($_GET["lang"]) && $_GET["lang"] == "ar" ){
				$error = array("msg"=>"الرجاء إدخال تأكيد كلمة المرور");
			}
			echo outputError($error);die();
		}
		$data = array("status"=>2);
		if ( selectDB("customers","`id` = '{$_POST["userId"]}'") ){
			if( updateDB("customers",$data,"`id` = '{$_POST["userId"]}'") ){
				$error = array("msg"=>"Account has been removed successfully");
				if ( isset($_GET["lang"]) && $_GET["lang"] == "ar" ){
					$error = array("msg"=>"تم حذف العضوية بنجاح");
				}
				echo outputData($error);die();
			}else{
				$error = array("msg"=>"Something wrong happened, Please try again.");
				if ( isset($_GET["lang"]) && $_GET["lang"] == "ar" ){
					$error = array("msg"=>"حصل خطأ اثناء محاولة حذف العضوية، الرجاء المحاولة مجددا");
				}
				echo outputError($error);die();
			}
		}else{
			$error = array("msg"=>"Wrong user id");
			if ( isset($_GET["lang"]) && $_GET["lang"] == "ar" ){
				$error = array("msg"=>"رمز عميل خاطئ");
			}
			echo outputError($error);die();
		}
		
	}else{
		$error = array("msg"=>"Please set type , 'login', 'social', 'register', 'guest', 'forgetpassword'.");
		echo outputError($error);die();
	}
}else{
	$error = array("msg"=>"Please set type , 'login', 'social', 'register', 'guest', 'forgetpassword'.");
	echo outputError($error);die();
}
?>