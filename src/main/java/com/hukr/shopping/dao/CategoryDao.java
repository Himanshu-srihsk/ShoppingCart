
package com.hukr.shopping.dao;

import com.hukr.shopping.entities.Category;
import java.util.List;
import javax.persistence.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;

/**
 *
 * @author KumarHimansh
 */
public class CategoryDao {
    private SessionFactory factory;
    public CategoryDao(SessionFactory factory){
        this.factory=factory;
    }
    public int saveCategory(Category cat){
        Session session=this.factory.openSession();
        Transaction tx= session.beginTransaction();
        int catId=(int)session.save(cat);
        tx.commit();
        session.close();
        return  catId;
    }
    public List<Category> getCategories(){
        Session session=this.factory.openSession();
        Query q=session.createQuery("from Category");
        List<Category> l=q.getResultList();
        return l;   
    }
    public Category getCategoryById(int cid){
        Category get=null;
        try{
             Session session=this.factory.openSession();
             get=session.get(Category.class, cid);
             session.close();
        } catch(Exception e){
            e.printStackTrace();
        }
        return get;
    }
}
