/**
* The SOQL class serves as a primer into the Salesforce Object Query Language in Apex.
* It covers fundamental aspects such as SELECT statements, WHERE clauses, Relationship queries, and LIMIT keyword.
*
* This class introduces developers to the concept of retrieving data from Salesforce using SOQL. It provides
* a step-by-step guide on how to construct SOQL queries, filter results using WHERE clause, retrieve related
* records, and manage data volume using the LIMIT keyword.
* 
* Topics covered in this class include:
* - Understanding the structure of a SOQL query.
* - Crafting basic SELECT statements in SOQL.
* - Applying filters using the WHERE clause in SOQL.
* - Fetching related records using Relationship queries.
* - Controlling the amount of data retrieved using the LIMIT keyword.
* 
* Users of this class can expect to gain a solid understanding of SOQL in Apex and
* be prepared to handle data retrieval tasks in Salesforce development.
* 
* @author David Bolding
*/

public with sharing class SOQL {
    
    /**
     * Question 1
     * Update/Uncomment the template code to create a method
     * Returns all leads from Salesforce Org
     * @return List of all leads with Id, LastName, Company, Phone, Email
     * Update the corresponding test class and testGetAllLeads method to cover this method
     */
    public static List<Lead> getAllLeads() {
    //  The body of the method
        List<Lead> leads = [SELECT id, LastName, Company, Phone, Email
        FROM Lead];

        return leads;
    }

    /**
     * Question 2
     * Update/Uncomment the template code to create a method
     * Returns all contacts with first name of John.
     * @return A list of Contact records.
     * Update the corresponding test class and testGetContactsByFirstName method to cover this method
     */
    public static List<Contact> getAllContacts() {
    //  The body of the method
        String firstName = 'John';
        List<Contact> contacts = [SELECT Id, FirstName, Name
                                 FROM Contact 
                                 WHERE FirstName = :firstName];

        Return contacts;
    }

    /**
     * Question 3
     * Update/Uncomment the template code to create a method
     * Returns the Contact Id for all contacts with last name of Smith or Jones
     * @return A list of Contact Ids.
     * Update the corresponding test class and testGetContactIdsByLastName method to cover this method
     */
    public static List<Id> getContactsByLastName() {
    //  The body of the method
        List<Id> ids = new List<Id>();    

        List<Contact> getContacts = [SELECT Id, LastName, Name
                                     FROM Contact 
                                     WHERE LastName IN ('Smith', 'Jones')];
                                     System.debug(getContacts);


        for (Contact con : getContacts) {
            System.debug(con);
                ids.add(con.Id);                           

            
        }
        
        return ids;
     }

    /**
     * Question 4
     * Update/Uncomment the template code to create a method
     * Returns List of closed won opportunities for a specific Account.
     * Example: yourMethodName('001XXXXXXXXXXXX') should return the list of closed won opportunities for the Account with the Id
     * @param accountId The ID of the Account.
     * @return A list of Opportunities with important opportunities fields
     * Update the corresponding test class and testGetClosedWonOpportunityCountByAccount method to cover this method
     */
    public static List<Opportunity> getClosedWonOpportunties(String account) {
    //  The body of the method
        List<Opportunity> opportunties = [SELECT Id, Name, StageName, AccountId, CloseDate, Amount
                                            FROM Opportunity
                                            WHERE Account.Id = :account AND StageName = 'Closed Won'];

        return opportunties;
    }

    /**
     * Question 5
     * Update/Uncomment the template code to create a method
     * Returns the total count of Account records.
     * @return The Integer count of Account records.
     * Update the corresponding test class and testGetAccountCount method to cover this method
     */
    public static Integer accountCountTotal() {
    //  The body of the method

        return [SELECT COUNT() FROM Account];
    }

    /**
     * Question 6
     * Update/Uncomment the template code to create a method
     * Return Key Value pair of Task Id and Task records for any tasks due date within the next 7 days.
     * @return A map of Task Ids to Task records.
     * Update the corresponding test class and testGetTasksDueNextWeek method to cover this method
     */
    public static Map<Id, Task> getTaskDueNextWeek() {

        Map<Id,Task> taskMap = new Map<Id, Task>();
        
        List<Task> taskDueDate = [SELECT Id, ActivityDate FROM Task WHERE ActivityDate = NEXT_N_DAYS:7];
        System.debug(taskDueDate);

    //  The body of the method
        for(Task task : taskDueDate) {
            if(taskDueDate.size() == 0) {
                continue;
            }else {
                System.debug(task);
                taskMap.put(task.ID, task);
            }

        }

        return taskMap;
    }

    /**
     * Question 7
     * Update/Uncomment the template code to create a method
     * Retrieves all Contacts that have a example.com domain in their Email.
     * @return A list of Contact records.
     * Update the corresponding test class and testGetContactsByEmailDomain method to cover this method
     */
    public static List<Contact> getContactsByEmail() {
    //  The body of the method
    String email = '%example.com%';
    List<Contact> contacts = [SELECT Id, Name, Email 
                             FROM Contact
                             WHERE Email LIKE :email ];

    return contacts;

    }

    /**
     * Question 8
     * Retrieves all Opportunities that have a specific keyword in their Name.
     * Example: getOpportunitiesByNameKeyword('keyword') should return all Opportunities that have 'keyword' in their Name.
     * @param keyword The keyword to search for in the Opportunity Name.
     * @return A list of Opportunity records.
     */
    public static List<Opportunity> getOpportunitiesByNameKeyword(String keyword) {
        String word = '%' + keyword + '%';

        List<Opportunity> opps = [SELECT Id, Name, StageName, CloseDate 
                                 FROM Opportunity
                                 WHERE Name Like :word];

        return opps; // Replace null with the variable you used to store the result
    }

    /**
     * Question 9
     * Retrieves all Cases that Case Origin is not Web or Email or Blank
     * @return A list of Case records.
     */
    public static List<Case> getFilterCaseOrigins() {

        List<Case> cases = [SELECT 
                            Id, Origin
                            FROM Case
                            WHERE Origin NOT IN ('Web', 'Email', '') ];

        return cases; 
    }

    /**
     * Question 10
     * Update/Uncomment the template code to create a method
     * Retrieves all Leads that have a specific Lead Source or contain a specific keyword in their Title.
     * Example: yourMethodName('Web', 'Engineer') should return all Leads that have 'Web' in their Lead Source or 'Engineer' in their Title.
     * @param leadSource The Lead Source to search for.
     * @param keyword The keyword to search for in the Lead Title.
     * @return A list of Lead records.
     * Update the corresponding test class and testGetLeadsBySourceOrTitle method to cover this method
     */
    public static List<Lead> getLeadsBySourceOrTitle(String leadSource, String title) {
    //  The body of the method
        String keyword = '%' + title + '%';

               
        
            List<Lead> leads = [ SELECT Id, Company, Phone, Email,LastName, LeadSource
                                 FROM Lead 
                                 WHERE LeadSource = :leadSource OR Title Like :keyword ];
      

        return leads;
       


    }    

    /**
     * Question 11
     * Returns the names of all Contacts associated with an Account.
     * Example: getContactNamesByAccount('001XXXXXXXXXXXX') should return the list of Contact LastNames for the Account with the Id
     * @param accountId The ID of the Account.
     * @return A list of Contact LastName.
     */
    public static List<String> getContactNamesByAccount(Id accountId) {
        // Create a list to hold the Contact LastNames
        List<String> contactLastNames = new List<String>();

        List<Contact> contacts = [SELECT Id, LastName
                                 FROM Contact 
                                 Where accountId = :accountId];

        // Query the Contacts
        // Loop through each Contact and add the LastName to the list
        for (Contact contactLastName : contacts) {
            
            String last = contactLastName.LastName;
            contactLastNames.add(last);        
            
          
        }

        // Return the list of Contact LastNames
        return contactLastNames; 
    }

    /**
     * Question 12
     * Returns the total revenue for all Opportunities in a specific Stage or if the amount is greater than 10000.
     * Example: getTotalRevenueByStage('Closed Won') should return the total revenue for all Opportunities in the 'Closed Won' Stage.
     * @param stage The Stage value to filter Opportunities.
     * @return The total revenue.
     */
    public static Decimal getTotalRevenueByStage(String stage) {
        // Use AggregateQuery to get the total revenue
        aggregateResult[] results = [SELECT SUM(Amount) totalRevenue FROM Opportunity WHERE StageName = :stage];

        Decimal totalRevenue = 0.0;

        if(results.size() > 0) {
            totalRevenue = (Decimal)results[0].get('totalRevenue');

        }

        // Return the total revenue
        return totalRevenue; 
    }

    /**
     * Question 13
     * Retrieves the first 10 Accounts ordered by Name.
     * @return A list of the first 10 Accounts ordered by Name.
     */
    public static List<Account> getFirstTenAccounts() {
        List<Account> accounts = [SELECT Id, Name From Account Order by Name Limit 10];
        return accounts; 
    }
    
    /**
     * Question 14
     * Retrieves the Opportunities with an Amount greater than 100,000, ordered by CloseDate, and limited to 5 records.
     * @return A list of Opportunities with an Amount greater than 100,000, ordered by CloseDate, and limited to 5 records.
     */
    public static List<Opportunity> getHighValueOpportunities() {

       List<Opportunity> opps = [SELECT Id, StageName, CloseDate, Name, Amount FROM Opportunity WHERE Amount > 100000 Order By CloseDate Limit 5];


        return opps; 
    }
    
    /**
     * Question 15
     * Retrieves the Contacts with the most recent Birthdate, ordered by Birthdate, and limited to 3 records.
     * @return A list of Contacts
     */
    public static List<Contact> getBirthdateContacts() {

        List<Contact> contacts = [SELECT Id, BirthDate, FirstName, LastName 
                                  FROM Contact 
                                  Order By Birthdate DESC NULLS LAST 
                                  Limit 3];
        
        return contacts; 
    }
    
    /**
     * Question 16
     * Retrieves the Cases in the Open Status, ordered by CreatedDate, and limited to 10 records with an offset of 5.
     * @return A list of Cases
     */
    public static List<Case> getCasesWithStatus() {
        List<Case> cases = [SELECT Id, Status, CreatedDate 
                            FROM Case 
                            WHERE Status = 'Open' 
                            Order By CreatedDate 
                            Limit 10
                            OFFSET 5];

        return cases; 
    }

    /**
     * Question 17
     * Returns Set of Case Ids for a specific Account.
     * Example: getCaseIdsByAccount('001XXXXXXXXXXXX') should return the set of Case Ids for the Account with the Id
     * @param accountId The ID of the Account.
     * @return A set of Case Ids.
     */
    public static Set<Id> getCaseIdsByAccount(Id accountId) {
        // Create a set to hold the Case Ids
        Set<Id> cases = new Set<Id>();

        // Query the Case
        List<Case> getCases = [SELECT Id
                              FROM Case 
                              WHERE accountId = :accountId];
        // Loop through each Case and add the Id to the set
        for (Case getCase : getCases) {
            String caseId = getCase.Id;
            cases.add(caseId);          
        }

        return cases; 
    }

    /**
     * Question 18
     * Return Map of Account Ids to Account Names Not in a specific Country.
     * Example: getAccountIdsToNamesNotInCountry('United States') should return the map of Account Ids to Account Names for Accounts that are not in the United States.
     * @param country The country to filter Accounts.
     * @return A map of Account Ids to Account Names.
     */
    public static Map<Id, String> getAccountIdsToNamesNotInCountry(String country) {
        // Create a map to hold the Account Ids to Account Names
        Map<Id, String> accountIdsToNames = new Map<Id, String>();

        // Query the Accounts
        List<Account> accounts = [SELECT Id, BillingCountry, Name FROM Account WHERE BillingCountry != :country];
        // Loop through each Account and add the Id and Name to the map
        for (Account acct :accounts) {
        
            accountIdsToNames.put(acct.Id, acct.Name);

        }

        return accountIdsToNames;
    }

    /**
     * Question 19
     * Retrieves the Account Name for a given Contact.
     * Example: getAccountNameForContact('003XXXXXXXXXXXX') should return the Account Name for the Contact with the Id
     * @param contactId The Id of the Contact.
     * @return The Account Name of the Contact.
     */
    public static String getAccountNameForContact(String contactId) {

      
            Contact contactsByAccount = [SELECT Id, Name, Email, AccountId, Account.Name
            FROM Contact 
            WHERE Id = :contactId];
            
            String accountName = contactsByAccount.Account.Name;
       

        return accountName; 
    }    

    /**
     * Question 20
     * Returns single Account that has related opportunities in the same query
     * Example: getOpportunityAndAccountNamesForLineItem('001XXXXXXXXXXXX') should return the Account Name for the Account with the Id and all related Opportunities
     * @param accountId The ID of the Account.
     * @return An Account record with related Opportunities.
     */
    public static Account getOpportunityAndAccountNamesForLineItem(Id accountId) {
        String acctId = (String)accountId;
        Account acct = [SELECT Id, Name, (SELECT Id, Name FROM Opportunities) FROM Account WHERE Id = :accountId];
      
          return acct;  

    }

    /**
     * Question 21
     * Retrieves all contacts that have the Mailing State similar to the Account Billing State.
     * Example: getAccountsWithContactsByState('001XXXXXXXXXXXX') should return a list of Contacts that have the same Mailing State as the Account with the Id
     * @param Account Id
     * @return List of contacts with the same Mailing State as the Account Billing State
     */
    public static List<Contact> getAccountsWithContactsByState(Id accountId) {
        // Query the Account
        Account acct = [SELECT Id, Name, BillingState FROM Account WHERE Id = :accountId];

        // Store the Account's BillingState
        String acctState = acct.BillingState;

        // Query the Contacts
        List<Contact> contacts = [SELECT Id, Name, MailingState FROM Contact WHERE MailingState = :acctState  ];
        return contacts; 
    }

    /**
     * Question 22
     * Extracts email domains from them leads, then finds Accounts with matching website domains
     * If Lead Email = test@test.com return account with website = www.test.com
     * Example: findContactsByLeadEmailDomains([set of lead ids]) should return a list of Accounts with matching email domains
     * @param A set of Lead Ids.
     * @return A list of Accounts with matching email domains.
     */
    public static List<Account> findContactsByLeadEmailDomains(Set<Id> leadIds) {
        // Query the Leads
        List<Lead> leads = [SELECT Id, FirstName, LastName, Email FROM Lead WHERE Id IN :leadIds];

        // Create a set of email domains from the Leads
        Set<String> webDomain = new Set<String>();


        // Loop through each Lead
        for (Lead leadEmail : leads) {
             // Get the email from the Lead
            // Check if the email is not null
            // Add the email domain to the set
            if (leadEmail.Email != null) {
                String seperator = leadEmail.Email.substringAfter('@');
                String website = 'www.' + seperator;
                webDomain.add(website);
            }
        }          

        
        // Query the Accounts
        List<Account> accts = [SELECt Id, Name, Website FROM Account WHERE Website IN :webDomain];
        return accts; // Replace null with the variable you used to store the result
    }

    /**
     * Question 23
     * Clones and Inserts Opportunity Line Items from an original Opportunity to a list of cloned Opportunities.
     * Adds a randomized number between 1 to 3 to the quantity of each line item.
     * Example: cloneLineItems('001XXXXXXXXXXXX', [list of opportunity ids]) should clone the line items from the Opportunity with the Id to each Opportunity in the list
     * @param Original Opportunity Id
     * @param List of cloned Opportunity Ids
     */
    public static void cloneLineItems(Id origOppId, List<Id> cloneOppIds) {
        // Query the original Opportunity Line Items
        List<OpportunityLineItem> ogLineItems = [SELECT Id, OpportunityId, Product2Id, Quantity, UnitPrice, PricebookEntryId
                                                FROM OpportunityLineItem
                                                WHERE OpportunityId = :origOppId ];

       
        // Create a list to hold the new line items
        List<OpportunityLineItem> newLineItems = new List<OpportunityLineItem>();

        // Generate a random number between 1 and 3
        Integer randomNumber = Integer.valueOf(Math.random() * 3) + 1;

        // Loop through each cloned Opportunity Id
        for(Id cloneOppId : cloneOppIds) {
             // Loop through each original line item
             for(OpportunityLineItem ogLineItem : ogLineItems) {
                OpportunityLineItem newItem = ogLineItem.clone();
                newItem.OpportunityId = cloneOppId;
                newItem.Quantity = randomNumber;
                newItem.PricebookEntryId = ogLineItem.PricebookEntryId;
                newItem.Product2Id = ogLineItem.product2Id;
                newItem.UnitPrice = ogLineItem.UnitPrice;
                newLineItems.add(newItem);

                 // Clone the original line item and add the random number to the quantity

             }
               

        }

           

        // Insert the new line items
        insert newLineItems;
    }
    
    /**
     * Question 24
     * Retrieves the Opportunity Name, Account Name, and Owner Name for Opportunities that have a Stage of 'Closed Won'.
     * Example: getOpportunityDetailsForClosedWon()
     * @return A list of filtered Opportunity
     */
    public static List<Opportunity> getOpportunityDetailsForClosedWon() {     
        List<Opportunity> opps = [SELECT Id, Name, Account.Name, AccountId, StageName, Owner.Name, Primary_Contact__c
                                 FROM Opportunity 
                                 WHERE StageName = 'Closed Won' ];
        System.debug(opps);
        return opps; // Replace null with the variable you used to store the result
    }

    /**
     * Question 25
     * Sets the 'Primary_Contact__c' field for all Closed Won Opportunities to first Contact on the Account.
     * Example: setPrimaryContact() should set the 'Primary_Contact__c' field for every Opportunity in the org
     */
    public static void setPrimaryContact() {
        //Use the getOpportunityDetailsForClosedWon() method to get the Opportunities
        List<Opportunity> opps = getOpportunityDetailsForClosedWon();
        

        // Create a set of Account Ids from the Opportunities
        Set<Id> oppAccountId = new Set<Id>();
        for(Opportunity oppId : opps) {
            oppAccountId.add(oppId.AccountId);

        }
        

        // Query the Contacts
        // Loop through each Contact and add the Account Id and Contact to the map
        Map<Id, Contact> accountToContactMap = new Map<Id, Contact>([            
            SELECT Id, AccountId
            FROM Contact 
            WHERE AccountId IN :oppAccountId]
        );
               
        
        // Loop through each Opportunity
        for (Opportunity opp : opps ) {
            if(accountToContactMap.containsKey(opp.AccountId)) {
                opp.Primary_Contact__c = accountToContactMap.get(opp.AccountId).Id;
                
                 // Update the Opportunity primary contact from accountToContactMap
            }

        }               

        // Update the Opportunities
        System.debug(opps);
        update opps;
    }
}