<?php

namespace Watson\Controller;

use Silex\Application;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;

class HomeController {

    /**
     * Home page controller.
     *
     * @param Application $app Silex application
     */
    public function indexAction(Application $app) {
        $links = $app['dao.link']->findAll();
        return $app['twig']->render('index.html.twig', array('links' => $links));
    }

    /**
     * Link details controller.
     *
     * @param integer $id Link id
     * @param Request $request Incoming request
     * @param Application $app Silex application
     */
    public function linkAction($id, Request $request, Application $app) {
        $link = $app['dao.link']->find($id);
        if ($app['security.authorization_checker']->isGranted('IS_AUTHENTICATED_FULLY')) {
            // A user is fully authenticated : he can add comments
            // Check if he's author for manage link

        }
        return $app['twig']->render('link.html.twig', array(
            'link' => $link
        ));
    }

    /**
     * Links by tag controller.
     *
     * @param integer $id Tag id
     * @param Request $request Incoming request
     * @param Application $app Silex application
     */
    public function tagAction($id, Request $request, Application $app) {
        $links = $app['dao.link']->findAllByTag($id);
        $tag   = $app['dao.tag']->findTagName($id);

        return $app['twig']->render('result_tag.html.twig', array(
            'links' => $links,
            'tag'   => $tag
        ));
    }

    /**
     * User login controller.
     *
     * @param Request $request Incoming request
     * @param Application $app Silex application
     */
    public function loginAction(Request $request, Application $app) {
        return $app['twig']->render('login.html.twig', array(
            'error'         => $app['security.last_error']($request),
            'last_username' => $app['session']->get('_security.last_username'),
            )
        );
    }

    /**
     * RSS Feed controller.
     *
     * @param Application $app Silex application
     */
    public function rssAction(Application $app) {
        // Récupérer les 15 derniers liens depuis la base de données
        $sql = "SELECT lien_url, lien_titre, lien_desc, NOW() AS created_at 
                FROM tl_liens 
                ORDER BY lien_id DESC 
                LIMIT 15";
        $links = $app['db']->fetchAll($sql);

        // Construire le contenu RSS
        $rssContent = '<?xml version="1.0" encoding="UTF-8"?>';
        $rssContent .= '<rss version="2.0">';
        $rssContent .= '<channel>';
        $rssContent .= '<title>Watson RSS Feed</title>';
        $rssContent .= '<link>http://localhost:165/</link>';
        $rssContent .= '<description>Les 15 derniers liens publiés sur Watson</description>';

        foreach ($links as $link) {
            $rssContent .= '<item>';
            $rssContent .= '<title>' . htmlspecialchars($link['lien_titre']) . '</title>';
            $rssContent .= '<link>' . htmlspecialchars($link['lien_url']) . '</link>';
            $rssContent .= '<description>' . htmlspecialchars($link['lien_desc']) . '</description>';
            $rssContent .= '<pubDate>' . (new \DateTime($link['created_at']))->format(DATE_RSS) . '</pubDate>';
            $rssContent .= '</item>';
        }

        $rssContent .= '</channel>';
        $rssContent .= '</rss>';

        // Retourner une réponse XML
        return new Response($rssContent, 200, ['Content-Type' => 'application/rss+xml']);
    }
}
