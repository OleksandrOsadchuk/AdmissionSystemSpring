/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import beans.Item;
import java.util.List;

/**
 *
 * @author pear
 */

public interface Dao {

    public List getAll(String tabname);

    public List getId(Item item);

    public int add(Item item);

    public int update(Item item);

    public int delete(Item item);

}
