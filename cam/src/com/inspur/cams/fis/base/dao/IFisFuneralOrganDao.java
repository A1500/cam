package com.inspur.cams.fis.base.dao;

import java.util.List;

import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.fis.base.data.FisFuneralOrgan;

/**
 * @Path com.inspur.cams.fis.base.dao.IFisFuneralOrganDao  
 * @Description: TODO 殡葬业务殡仪馆信息表Dao的接口
 * @author jiangzhaobao
 * @date 2011-11-15
 */
 public interface IFisFuneralOrganDao extends BaseCURD<FisFuneralOrgan>{
	public void save(List<FisFuneralOrgan> list);
	   /**
	   * @Title: queryForExport
	   * @Description: TODO(数据导出时查询方法)
	   * @param pSet
	   * @return DataSet  
	   * @throws
	   * @author luguosui
	    */
	   public DataSet queryForExport(ParameterSet pSet);
}

