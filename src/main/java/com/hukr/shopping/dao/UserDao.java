package com.hukr.shopping.dao;


import com.hukr.shopping.entities.User;
import java.util.List;
import javax.persistence.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.internal.util.SerializationHelper;


public class UserDao {
    private SessionFactory factory;
    public UserDao(SessionFactory factory){
        this.factory=factory;
    }
    public User getUserByEmailAndPassword(String email,String password){
        User user=null;
        try{
           String query = "from User where userEmail =: e and userPassword =:p";
           
           Session session=this.factory.openSession();
           
           Query q=session.createQuery(query);
           q.setParameter("e",email);
           

           q.setParameter("p",password);
//           user= (User) q.getSingleResult(); //uniqueResult method deprecated with 5.2.2

            List results = q.getResultList();

            if (results != null && !results.isEmpty()) {
                user = (User) results.get(0);
            }
           
           
           
           session.close();
           
        }catch(Exception e){
            e.printStackTrace();
        }
       return user; 
    }
}
