Feature: Petstore API Test

  Background:
    * url 'https://petstore.swagger.io/v2'

  Scenario: Get available pets
    Given path 'pet', 'findByStatus'
    And param status = 'available'
    When method get
    Then status 200
    And match response[0].id == '#notnull'
    And match response[0].name == '#string'
    And match response[0].status == 'available'
    And match response[0].tags == '#present'
    And match response[0].tags == '#array'

  Scenario: Verify add pet API in Petstore
	* def name = "doggesh"
	  Given path 'pet'
	  And header Content-Type = 'application/json'
	  And request
	  """
	  {
	    "id": 111,
	    "category": {
	      "id": 111,
	      "name": "string"
	    },
	    "name": "#(name)",
	    "photoUrls": [
	      "string"
	    ],
	    "tags": [
	      {
	        "id": 111,
	        "name": "string"
	      }
	    ],
	    "status": "available"
	  }
	  """
	  When method post
	  Then status 200
	  And match response.name == name
	  
	  Scenario: Get pet with pet Id
    * def id = 111
    Given path 'pet', id
    When method get
    Then status 200
    And match response.id == id
	  
	  Scenario: Verify add pet API in Petstore from Json File
	* def name = "Cheema"
	* def payload = read("../testdata/request.json")
	  Given path 'pet'
	  And header Content-Type = 'application/json'
	  And request payload 
	  When method post
	  Then status 200
	  And match response.name == name
	  
	  Scenario: Verify update pet API in Petstore
	* def name = "doggesh"
	  Given path 'pet'
	  And header Content-Type = 'application/json'
	  And request
	  """
	  {
	    "id": 0,
	    "category": {
	      "id": 0,
	      "name": "string"
	    },
	    "name": "#(name)",
	    "photoUrls": [
	      "string"
	    ],
	    "tags": [
	      {
	        "id": 0,
	        "name": "string"
	      }
	    ],
	    "status": "available"
	  }
	  """
	  When method post
	  Then status 200
	  And match response.name == name
	  
	  * def id = response.id
	  * def updateName = "doggy"
	  Given path 'pet'
	  And header Content-Type = 'application/json'
	  And request
	  """
	  {
	    "id": 0,
	    "category": {
	      "id": 0,
	      "name": "string"
	    },
	    "name": "#(updateName)",
	    "photoUrls": [
	      "string"
	    ],
	    "tags": [
	      {
	        "id": 0,
	        "name": "string"
	      }
	    ],
	    "status": "available"
	  }
	  """
	  When method post
	  Then status 200
	  And match response.name == updateName
	  
	  Scenario: Verify delete pet API in Petstore
	* def name = "doggesh"
	* def petId = 9999 
	  Given path 'pet'
	  And header Content-Type = 'application/json'
	  And request
	  """
	  {
	    "id": #(petId),
	    "category": {
	      "id": 0,
	      "name": "string"
	    },
	    "name": "#(name)",
	    "photoUrls": [
	      "string"
	    ],
	    "tags": [
	      {
	        "id": 0,
	        "name": "string"
	      }
	    ],
	    "status": "available"
	  }
	  """
	  When method post
	  Then status 200
	  And match response.name == name
	  And match response.id == petId
	  
	  * def id = response.id
	   	Given path 'pet', id
    	When method delete
    	Then status 200
     
	   	Given path 'pet', id
    	When method get
    	Then status 404
	  
	  
