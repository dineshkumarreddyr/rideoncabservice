<?php
function mailer($to, $subject, $message) {
    // Always set content-type when sending HTML email
    $headers = "MIME-Version: 1.0" . "\r\n";
    $headers .= "Content-Type: text/html; charset=ISO-8859-1\r\n";

    // More headers
    $headers .= 'From: <roc@crestdzines.com>' . "\r\n";
    // $headers .= "Reply-To: <roc@crestdzines.com>' . "\r\n";
    // $headers .= 'Cc: myboss@example.com' . "\r\n";

    if(mail($to,$subject,$message,$headers)) {
        return TRUE;
    } else {
        return FALSE;
    }
}
?>