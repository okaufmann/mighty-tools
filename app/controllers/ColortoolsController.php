<?php

class ColortoolsController extends \Phalcon\Mvc\Controller {

    public function indexAction() {
        if ($this->request->isPost()) {
            $fieldColors = $this->request->get("fieldColors");
            $this->view->fieldColors = $fieldColors;
            $exposedInput = preg_split("/\n/", $fieldColors);

            $this->view->colors = $exposedInput;
        }
    }

}
