package com.inspur.cams.fis.ep.base.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.fis.ep.base.data.FisCemeAccessories;

/**
 * @title:IFisCemeAccessoriesDao
 * @description:
 * @author:
 * @since:2011-11-30
 * @version:1.0
*/
 public interface IFisCemeAccessoriesDao extends BaseCURD<FisCemeAccessories>{
	public void save(List<FisCemeAccessories> list);

	/**
	 * 查询附件信息
	 * @param pset
	 * @return
	 */
	public DataSet queryAccessoriesItem(ParameterSet pset);

	/**
	 * 查询附件明细
	 * @param pset
	 * @return
	 */
	public DataSet queryAccessories(ParameterSet pset);
}

