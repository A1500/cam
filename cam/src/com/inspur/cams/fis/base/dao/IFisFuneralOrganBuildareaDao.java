package com.inspur.cams.fis.base.dao;

import java.util.List;

import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.fis.base.data.FisFuneralOrganBuildarea;

/**
 * @Path com.inspur.cams.fis.base.dao.IFisFuneralOrganBuildareaDao
 * @Description: TODO 殡葬业务殡仪馆信息表Dao的接口
 * @author xuexzh
 * @date 2012-7-12
 */
public interface IFisFuneralOrganBuildareaDao extends BaseCURD<FisFuneralOrganBuildarea> {
	public void save(List<FisFuneralOrganBuildarea> list);

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
