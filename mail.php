<?php
include "classes/class.phpmailer.php"; // include the class name

function mailer($to, $subject, $message) {

    $message_header = '
    <html>
      <body style="margin:0;padding:0;font-family: Roboto, sans-serif;">
       <div class="wrapper" style="width:650px;margin:0 auto;background:#f5f5f5;">
         <div class="header" style="padding:15px;background:#000;text-align:center;border-top:5px solid #e38e00">
           <img src="http://www.rideoncab.com/app/assets/images/logo.png">
         </div>';
    $message_footer = '
        <div class="footer-wrap" style="background: #242424;padding-top:15px;padding-bottom:15px;text-align: center">
            <div>Search • Compare • Book</div>
            <div class="footer-wrap-links" style="margin-top:10px;">
                <a href="http://www.rideoncab.com/home/termsandconditions" style="font-size: 12px;color: #ebebeb;text-transform: uppercase;padding: 10px;text-decoration:none;">Terms &amp; Conditions</a>
                <a href="http://www.rideoncab.com/home/aboutus" style="font-size: 12px;color: #ebebeb;text-transform: uppercase;padding: 10px;text-decoration:none;">about us</a>
                <a href="http://www.rideoncab.com/home/carrers" style="font-size: 12px;color: #ebebeb;text-transform: uppercase;padding: 10px;text-decoration:none;">careers</a>
                <a href="http://www.rideoncab.com/vendor/signin" style="font-size: 12px;color: #ebebeb;text-transform: uppercase;padding: 10px;text-decoration:none;">be a vendor</a>
                <a href="http://www.rideoncab.com/home/contactus" style="font-size: 12px;color: #ebebeb;text-transform: uppercase;padding: 10px;text-decoration:none;">reach us</a>
            </div>
            <div class="footer-wrap-links" style="margin-top:10px;">
                <a href="https://www.facebook.com/rideoncab" target="_blank" style="font-size: 12px;color: #ebebeb;text-transform: uppercase;padding: 10px;text-decoration:none;"><img src="http://www.rideoncab.com/app/assets/images/fb.png"></a>
                <a href="https://twitter.com/rideoncab" target="_blank" style="font-size: 12px;color: #ebebeb;text-transform: uppercase;padding: 10px;text-decoration:none;"><img src="http://www.rideoncab.com/app/assets/images/twitter.png"></a>
                <a href="#" style="font-size: 12px;color: #ebebeb;text-transform: uppercase;padding: 10px;text-decoration:none;"><img src="http://www.rideoncab.com/app/assets/images/gplus.png"></a>
            </div>
        </div>
       </div>   
      </body>
    </html>';

    $message_body = '
    <div class="wrapmain" style="padding:30px;text-align:center">
     <h2 style="font-size:30px;text-align:center;color:#e38e00;font-weight:700;margin-top:0;">Thankyou!</h2>
     <p style="font-size:15px;line-height:21px;color:#000;text-align:center;">For booking a cab with Ride on Cab. 
     Looking forward for more and more Orders from you.
     Have a safe and Happy Ride!</p>
     <a href="#" style="color:#;text-decoration:none;">http://www.rideoncab.com/setpassword.html</a>
    </div>';

    $message = $message_header . $message . $message_footer;

    $mail = new PHPMailer(); // create a new object
    $mail->IsSMTP(); // enable SMTP
    $mail->SMTPDebug = 1; // debugging: 1 = errors and messages, 2 = messages only
    $mail->SMTPAuth = true; // authentication enabled
    $mail->SMTPSecure = 'ssl'; // secure transfer enabled REQUIRED for GMail
    $mail->Host = "smtp.zoho.com";
    $mail->Port = 465; // or 587
    $mail->IsHTML(true);
    $mail->Username = "mail_roc@rideoncab.com";
    $mail->Password = "ROC@12345";
    $mail->SetFrom("mail_roc@rideoncab.com");
    $mail->Subject = $subject;
    $mail->Body = $message;
    $mail->AddAddress($to);
    if($mail->Send()) {
        return TRUE;
    } else {
        return FALSE;
    }
}
?>