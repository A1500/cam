package com.inspur.cams.bpt.base.domain.support;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.bpt.base.dao.IBptPeopleMartyrOffspringDao;
import com.inspur.cams.bpt.base.data.BptPeopleMartyrOffspring;
import com.inspur.cams.bpt.base.domain.IBptPeopleMartyrOffspringDomain;

/**
 * @title:IBptPeopleMartyrOffspringDao
 * @description:部分烈士（错杀被平反人员）子女 类别信息 domain层实现
 * @author:
 * @since: 
 * @version: 
*/
 public class BptPeopleMartyrOffspringDomain implements IBptPeopleMartyrOffspringDomain{
	 
	 @Reference
	 IBptPeopleMartyrOffspringDao peopleMartyrOffspringDao;
	 /**
	  * 添加
	  * @param bptPeopleMartyrOffspring
	  */
	 public void insert(BptPeopleMartyrOffspring bptPeopleMartyrOffspring){
		 List list = new ArrayList();
		 list.add(bptPeopleMartyrOffspring);
		 peopleMartyrOffspringDao.save(list);
		// peopleMartyrOffspringDao.insert(bptPeopleMartyrOffspring);
	 }
	 /**
	  * 删除
	  * @param bptPeopleMartyrOffspring
	  */
	 public void delete(BptPeopleMartyrOffspring bptPeopleMartyrOffspring){
		 peopleMartyrOffspringDao.delete(bptPeopleMartyrOffspring);
	 }
	 /**
	  * 修改
	  * @param bptPeopleMartyrOffspring
	  */
	 public void update(BptPeopleMartyrOffspring bptPeopleMartyrOffspring){
		 peopleMartyrOffspringDao.update(bptPeopleMartyrOffspring);
	 }
	 /**
	  * 查询
	  * @param pset
	  * @return
	  */
	 public DataSet query(ParameterSet pset){
		 return peopleMartyrOffspringDao.query(pset);
	 }
	 
	 public DataSet queryMartyrOffspring(ParameterSet pset){
		 return peopleMartyrOffspringDao.queryMartyrOffspring(pset);
	 }
}

