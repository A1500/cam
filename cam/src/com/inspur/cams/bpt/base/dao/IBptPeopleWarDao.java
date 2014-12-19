package com.inspur.cams.bpt.base.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.bpt.base.data.BptPeopleWar;

/**
 * @title:IBptPeopleWarDao
 * @description:
 * @author:
 * @since:2011-05-12
 * @version:1.0
*/
 public interface IBptPeopleWarDao extends BaseCURD<BptPeopleWar>{
	public void save(List<BptPeopleWar> list);
	public DataSet queryWar(ParameterSet pset);
	
	/**
	 * 查询未提交参战人员
	 * @param pSet
	 * @return
	 */
	public DataSet queryUnCommitWar(ParameterSet pSet) ;
	
}

