<?php
if ( isset($_GET["type"]) && !empty($_GET["type"]) ){
	if( $_GET["type"] == "loginVendor" ){
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
		if($user = selectDB('vendors',"`email` LIKE '".$_POST["email"]."' AND `password` LIKE '".sha1($_POST["password"])."'")){
			if( $user[0]["status"] == 1 ){
				$error = array("msg"=>"Your account has been blocked. Please aconatct administration.");
				if ( isset($_GET["lang"]) && $_GET["lang"] == "ar" ){
					$error = array("msg"=>"حسابك تم إيقافه الرجاء التواصل مع الإدارة");
				}
				echo outputError($error);die();
			}
			if ( isset($_POST["deviceToken"]) && !empty($_POST["deviceToken"]) ){
				if ($firebase = selectDB('vendors',"`id` LIKE '{$user[0]["id"]}'") ){
					$data = array(
						"deviceToken"=>$_POST["deviceToken"]
					);
					updateDB('vendors',$data," `id` LIKE '{$user[0]["id"]}'");
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
	}elseif( $_GET["type"] == "loginDriver" ){
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
		if($user = selectDB('user',"`username` LIKE '".$_POST["email"]."' AND `password` LIKE '".sha1($_POST["password"])."'")){
			if( $user[0]["status"] == 1 ){
				$error = array("msg"=>"Your account has been blocked. Please aconatct administration.");
				if ( isset($_GET["lang"]) && $_GET["lang"] == "ar" ){
					$error = array("msg"=>"حسابك تم إيقافه الرجاء التواصل مع الإدارة");
				}
				echo outputError($error);die();
			}
			if ( isset($_POST["deviceToken"]) && !empty($_POST["deviceToken"]) ){
				if ($firebase = selectDB('user',"`id` LIKE '{$user[0]["id"]}'") ){
					$data = array(
						"deviceToken"=>$_POST["deviceToken"]
					);
					updateDB('user',$data," `id` LIKE '{$user[0]["id"]}'");
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
	}elseif( $_GET["type"] == "forgetPasswordDriver" ){
		if ( !isset($_POST["email"]) || empty($_POST["email"]) ){
			$error = array("msg"=>"Please fill email");
			if ( isset($_GET["lang"]) && $_GET["lang"] == "ar" ){
				$error = array("msg"=>"الرجاء إدخال البريد الإلكتروني");
			}
			echo outputError($error);die();
		}
		if( selectDB('user',"`email` LIKE '".$_POST["email"]."'") ){
			$random = rand(11111111,99999999);
			$data = array(
					"password"=>sha1($random)
			);
			updateDB('user',$data," `email` LIKE '{$_POST["email"]}'");
			$curl = curl_init();
			curl_setopt_array($curl, array(
			  CURLOPT_URL => 'myid.createkwservers.com/api/v1/send/notify',
			  CURLOPT_RETURNTRANSFER => true,
			  CURLOPT_ENCODING => '',
			  CURLOPT_MAXREDIRS => 10,
			  CURLOPT_TIMEOUT => 0,
			  CURLOPT_FOLLOWLOCATION => true,
			  CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
			  CURLOPT_CUSTOMREQUEST => 'POST',
			  CURLOPT_POSTFIELDS => array('site' => '- EZYO Delivery','subject' => 'New Password','body' => 'Your new password is: '.$random.'<br><br>(Note: Please change your passowrd as soon as you login in app.)','from_email' => 'noreply@ezyo.com','to_email' => $_POST["email"]),
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
	}elseif( $_GET["type"] == "forgetPasswordVendor" ){
		if ( !isset($_POST["email"]) || empty($_POST["email"]) ){
			$error = array("msg"=>"Please fill email");
			if ( isset($_GET["lang"]) && $_GET["lang"] == "ar" ){
				$error = array("msg"=>"الرجاء إدخال البريد الإلكتروني");
			}
			echo outputError($error);die();
		}
		if( selectDB('vendors',"`email` LIKE '".$_POST["email"]."'") ){
			$random = rand(11111111,99999999);
			$data = array(
					"password"=>sha1($random)
			);
			updateDB('vendors',$data," `email` LIKE '{$_POST["email"]}'");
			$curl = curl_init();
			curl_setopt_array($curl, array(
			  CURLOPT_URL => 'myid.createkwservers.com/api/v1/send/notify',
			  CURLOPT_RETURNTRANSFER => true,
			  CURLOPT_ENCODING => '',
			  CURLOPT_MAXREDIRS => 10,
			  CURLOPT_TIMEOUT => 0,
			  CURLOPT_FOLLOWLOCATION => true,
			  CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
			  CURLOPT_CUSTOMREQUEST => 'POST',
			  CURLOPT_POSTFIELDS => array('site' => '- EZYO Delivery','subject' => 'New Password','body' => 'Your new password is: '.$random.'<br><br>(Note: Please change your passowrd as soon as you login in app.)','from_email' => 'noreply@ezyo.com','to_email' => $_POST["email"]),
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
	}else{
		$error = array("msg"=>"Please set type , 'login', 'forgetpassword'.");
		echo outputError($error);die();
	}
}else{
	$error = array("msg"=>"Please set type , 'login', 'social', 'register', 'guest', 'forgetpassword'.");
	echo outputError($error);die();
}
?>