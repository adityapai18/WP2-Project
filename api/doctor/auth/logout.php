<?php
 session_start();
 session_destroy();
 header('Location: ../../../doc_end/home/static', true);
?>