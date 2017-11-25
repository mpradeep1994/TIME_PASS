
# coding: utf-8

# In[38]:


import csv
import pandas as pd
import numpy as np
from sklearn import tree
from sklearn.metrics import accuracy_score
from sklearn.metrics import confusion_matrix
import re
from sklearn.preprocessing import LabelBinarizer
from sklearn.model_selection  import train_test_split
from sklearn.model_selection  import KFold
from sklearn import svm
from sklearn.linear_model import LogisticRegression
from sklearn.metrics import accuracy_score


# In[39]:


df1= pd.read_csv("C:\Users\Pradeep\Google Drive\GitHub\suganya work\initialMemberMeetingAttendees.csv")


# In[40]:


### Level2
df1.level2.fillna('UN', inplace=True)
level2_dummy = pd.get_dummies(df1['level2'], prefix='level2')
df1 = pd.concat([df1,level2_dummy], axis=1)
df1.drop('level2', axis=1, inplace=True)


# In[41]:


### level3
df1.level3.fillna('UN', inplace=True)
level3_dummy = pd.get_dummies(df1['level3'], prefix='level3')
df1 = pd.concat([df1,level3_dummy], axis=1)
df1.drop('level3', axis=1, inplace=True)


# In[42]:


### Unnamed . Changing the feature name to Department_
df1.department.fillna('UN', inplace=True)
department_dummy = pd.get_dummies(df1['department'], prefix='department')
df1 = pd.concat([df1,department_dummy], axis=1)
df1.drop('department', axis=1, inplace=True)


# In[43]:


### City
df1.city.fillna('UN', inplace=True)
city_dummy = pd.get_dummies(df1['city'], prefix='city')
df1 = pd.concat([df1,city_dummy], axis=1)
df1.drop('city', axis=1, inplace=True)


# In[44]:


### column state is dropped
df1.drop('state',axis=1,inplace=True)


# In[45]:


### country
df1.country.fillna('UN', inplace=True)
country_dummy = pd.get_dummies(df1['country'], prefix='country')
df1 = pd.concat([df1,country_dummy], axis=1)
df1.drop('country', axis=1, inplace=True)


# In[46]:


### Conitnent
df1.continent.fillna('UN', inplace=True)
continent_dummy = pd.get_dummies(df1['continent'], prefix='continent')
df1 = pd.concat([df1,continent_dummy], axis=1)
df1.drop('continent', axis=1, inplace=True)


# In[47]:


# gender
df1.gender.fillna('unknown', inplace=True)
df1['gender']=df1['gender'].map({'MALE':1,'FEMALE':0,'NULL':2,'unknown':3})
df1['gender']=df1.gender.astype(int)


# In[48]:


"""df1['age']=df1.age.astype(int)
df1.age.fillna(df1.age.median(), inplace=True)
df1.drop('age', axis=1, inplace=True)
"""
# age
val= {'#VALUE!':0}
df1['age']=df1['age'].replace(val)


# In[49]:


val= {0:df1.age.median()}
df1['age']=df1['age'].replace(val)


# In[50]:


# practice
df1.practice.fillna('UN', inplace=True)
practice_dummy = pd.get_dummies(df1['practice'], prefix='practice')
df1 = pd.concat([df1,practice_dummy], axis=1)
df1.drop('practice', axis=1, inplace=True)


# In[51]:


""""
###df1.attendees.fillna('unknown', inplace=True)
###df1['attendees']=df1['attendees'].map({'RG??':1,'unknown':0,'NaN':0})
regex_pat = re.compile(r'NaN',flags=re.IGNORECASE)
###pd.Series(df1['attendees']).str.replace(regex_pat,'0')
df1['attendees']=df1.attendees.str.replace(r'Nan','0')
###df1['attendees']=df1.attendees.astype(int)

lb_style = LabelBinarizer()
lb_results = lb_style.fit_transform(df1["level3"])
df1=pd.concat([df1,pd.DataFrame(lb_results)],axis=1)
df1.drop('level3',axis=1,inplace=True)
###df1['attendees'] =re.sub(r"^[0-9a-zA-Z]+","0",df1.attendees) 
#df1['attendees']=df1['attendees'].replace(to_replace="NaN",value="\0",regex=True,inplace=True)
# del df1['attendees']
# y= pd.read_csv("C:\\Users\\ar1\\Desktop\\InitialMemberMeetingAttendees.csv")
"""


# In[52]:


df1['attendees'].value_counts()


# In[53]:


y= df1


# In[54]:


y['attendees']=(y.attendees.notnull()).astype('int')
y['attendees']=y['attendees'].fillna(0)

#df1=df1.join(y['attendees'])


# In[55]:


df1['attendees'].value_counts()


# In[56]:


#rows X Columns
df1.shape


# In[57]:


#get only 2500 rows
df1=df1.iloc[:5000]


# In[58]:


#rows X Columns
df1.shape


# In[59]:


y = df1.pop('attendees')
X = df1


# In[60]:


X_train,X_test,y_train,y_test = train_test_split(X,y,test_size=0.4,random_state=42)


# In[61]:


#identify accuracy by using the K fold method
def do_cross_validation(X, y,clf, n_folds=5):
    cv = KFold(len(y), n_folds)
    accuracies = []
    for train_ind, test_ind in cv: 
        #print (train_ind, test_ind)
        clf.fit(X[train_ind], y[train_ind])
        predictions = clf.predict(X[test_ind])
        accuracies.append(accuracy_score(y[test_ind], predictions))
    avg = np.mean(accuracies)
    return avg


# In[62]:


def decisionTree():
    return tree.DecisionTreeClassifier(class_weight=None, criterion='gini', max_depth=None,
            max_features=None, max_leaf_nodes=None, min_samples_leaf=1,
            min_samples_split=2, min_weight_fraction_leaf=0.0,
            presort=False, random_state=None, splitter='best')


# In[63]:


def find_accuracy(matrix):
    return np.trace(matrix)*1.0/np.sum(matrix)


# In[65]:


#Logistic
clf = LogisticRegression()
clf.fit(X_train,y_train)
predictedY=clf.predict(X_test)


# In[66]:


accuracy_score(y_test, predictedY)


# In[67]:


#descision tree
clf = decisionTree()
clf.fit(X_train,y_train)
predictedY=clf.predict(X_test)


# In[68]:


accuracy_score(y_test, predictedY)

