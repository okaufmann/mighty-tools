<?php

/**
 * Add your routes here
 */
$app->get('/', function () use ($app) {
    echo $app['view']->getRender(null, 'index');
});

$app->post('/check', function () use ($app) {
    
    $checkRequest = $app->request->getJsonRawBody();

    $urlToCheck = $checkRequest->sitemap_url;

    //$xmlData = file_get_contents($urlToCheck);

    $xml = simplexml_load_file($urlToCheck);

    $i = 0;

    $errors = array();

    if (isset($xml)) {
        foreach ($xml->url as $entry) {
            $url =  (string)$entry->loc;
            $file_headers = @get_headers($url);
            if ($file_headers[0] == 'HTTP/1.1 404 Not Found') {
                $errors[] = $url;
            } 
            $i++;
            $file_headers = null;
        }
    }

    $response = new Phalcon\Http\Response();
    $response->setContentType('application/json');

    $execTime = microtime(true) - $_SERVER["REQUEST_TIME_FLOAT"];
    
    $response->setJsonContent(array(
        'status' => 'OK',
        'executionTime' => round($execTime, 4),
        'entries' => $i,
        'data' => $urlToCheck,
        'errors' => $errors,
    ));

    return $response;
});

/**
 * Not found handler
 */
$app->notFound(function () use ($app) {
    $app->response->setStatusCode(404, "Not Found")->sendHeaders();
    echo $app['view']->getRender(null, '404');
});
