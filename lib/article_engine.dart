import 'package:technicalsand/article.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const String _site = 'https://technicalsand.com';
const String _params = '/wp-json/wp/v2/posts?_fields=id,excerpt,title,link,jetpack_featured_media_url';

class ArticleEngine {
  int _articleNumber = 0;

  Future<List<Article>> getPosts(int page) async {
    var url = _site + _params + '&per_page=30';
    print('Hitting page: $url');
    var client = http.Client();
    try {
      var response = await client.get(url);
      print(response.body);
      final list = jsonDecode(response.body.toString());

      List<Article> articles = new List();

      for (final art in list) {
        articles.add( Article.fromJson(art, response.headers));

      }
      return articles;
    } finally {
      client.close();
      print('url hit complete');
    }
  }


  List<Article> articles = [
    Article(
        id: 1,
        title: 'Spring Boot 2.3 Features',
        url: 'https://technicalsand.com/spring-boot-2-3-features',
        imageUrl:
            'https://i0.wp.com/technicalsand.com/wp-content/uploads/2020/05/Spring-boot-2.3-release.png?w=640&ssl=1',
        description:
            'The latest update Spring Boot 2.3 is now available. Spring Boot 2.3 adds a few new noteworthy features, fixes some issues, updates dependencies, and includes improvements. Spring Boot is an open source framework based on Java. Originally developed by Pivotal, it helps users create stand-alone, production-grade Spring-based applications with minimal configuration. Changes to minimum requirements'),
    Article(
        id: 2,
        title: 'Level Order Tree Traversal',
        url: 'https://technicalsand.com/level-order-tree-traversal/',
        imageUrl:
            'https://i0.wp.com/technicalsand.com/wp-content/uploads/2020/05/Level-Order-Tree-Traversal.png?w=1332&ssl=1',
        description:
            'Problem statement:You are given a pointer to the root of a binary tree. You need to print the level order traversal of this tree. In level order traversal, we visit the nodes level by level from left to right.ORaGiven a binary tree, print its nodes level by level. i.e. all nodes present at level 1'),
    Article(
        id: 3,
        title: 'Tree Traversals – Inorder, Preorder, Postorder',
        url: 'https://technicalsand.com/tree-traversals-inorder-preorder-postorder/',
        imageUrl:
            'https://i0.wp.com/technicalsand.com/wp-content/uploads/2020/05/Tree-Traversals.jpg?w=1022&ssl=1',
        description:
            'Tree traversal is a form of graph traversal and refers to the process of visiting (checking and/or updating) each node in a tree data structure, exactly once. Such traversals are classified by the order in which the nodes are visited. Tree traversal is also known as tree search and walking the tree. Traversing a tree'),
    Article(
        id: 4 ,
        title: 'JDK 14: New Hot Features',
        url: 'https://technicalsand.com/jdk-14-new-hot-features/',
        imageUrl:
        'https://i1.wp.com/technicalsand.com/wp-content/uploads/2020/05/Java-14-features.png?w=1366&ssl=1',
        description:
        'Java 14 (Java SE 14) and its Java Development Kit 14 (JDK 14) open-source has been released on 17 March 2020, the most common coding language and application platform in the world. Oracle now offers Java 14 for all developers and enterprises to download. Highlights of the latest GA release of standard Java include flight'),
    Article(
        id: 5 ,
        title: 'JUnit 5: How To Use And Migrate From JUnit 4',
        url: 'https://technicalsand.com/junit-5-how-to-use-and-migrate-from-junit-4/',
        imageUrl:
        'https://i1.wp.com/technicalsand.com/wp-content/uploads/2019/07/m1-1.jpg?w=760&ssl=1',
        description:
        'This tutorial explains the Junit 5’s most common annotations with examples. JUnit 5 is the next generation of JUnit.The goal is to create an up-to-date foundation for developer-side testing on the JVM. This includes focusing on Java 8 and above, as well as enabling many different styles of testing. Learn how it’s different from JUnit '),
  ];

  Article getArticle(){
    return findArticle(_articleNumber);
  }
  void getPreviousArticle(){
    _articleNumber--;
  }
  void getNextArticle(){
    _articleNumber++;
  }
  Article findArticle(int number){
    print('number: $number');
     if(number >= articles.length ){
       _articleNumber = _articleNumber;
       number = 0;
     }
     if(number < 0){
      _articleNumber = articles.length - 1;
      number = _articleNumber;
    }
     return articles[number];
   }
}
