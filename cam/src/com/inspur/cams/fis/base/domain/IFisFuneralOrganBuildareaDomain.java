package com.inspur.cams.fis.base.domain;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;
import com.inspur.cams.fis.base.data.FisFuneralOrganBuildarea;

/**
 * @Path com.inspur.cams.fis.base.domain.IFisFuneralOrganBuildareaDomain
 * @Description: TODO 殡葬业务殡仪馆信息表Domain的接口
 * @author xuexzh
 * @date 2012-7-12
 */
public interface IFisFuneralOrganBuildareaDomain {

	public DataSet query(ParameterSet pset);

	@Trans
	public void save(List<FisFuneralOrganBuildarea> list);

	@Trans
	public void insert(FisFuneralOrganBuildarea bean);

	@Trans
	public void update(FisFuneralOrganBuildarea bean);

	@Trans
	public void delete(String[] delIds);

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
