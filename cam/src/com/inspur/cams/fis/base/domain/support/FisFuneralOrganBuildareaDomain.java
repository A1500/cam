package com.inspur.cams.fis.base.domain.support;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;
import com.inspur.cams.fis.base.dao.IFisFuneralOrganBuildareaDao;
import com.inspur.cams.fis.base.data.FisFuneralOrganBuildarea;
import com.inspur.cams.fis.base.domain.IFisFuneralOrganBuildareaDomain;

/**
 * @Path com.inspur.cams.fis.base.domain.support.FisFuneralOrganBuildareaDomain
 * @Description: TODO 殡葬业务殡仪馆信息表domain的实现
 * @author xuexzh
 * @date 2012-7-12
 */
public class FisFuneralOrganBuildareaDomain implements IFisFuneralOrganBuildareaDomain {

	@Reference
	private IFisFuneralOrganBuildareaDao fisFuneralOrganBuildareaDao;

	public void delete(String[] delIds) {
		fisFuneralOrganBuildareaDao.batchDelete(delIds);
	}

	public void insert(FisFuneralOrganBuildarea bean) {
		fisFuneralOrganBuildareaDao.insert(bean);
	}

	public DataSet query(ParameterSet pset) {
		return fisFuneralOrganBuildareaDao.query(pset);
	}

	public void save(List<FisFuneralOrganBuildarea> list) {
		fisFuneralOrganBuildareaDao.save(list);
	}

	public void update(FisFuneralOrganBuildarea bean) {
		fisFuneralOrganBuildareaDao.update(bean);
	}

	/**
	 * @Title: queryForExport
	 * @Description: TODO(数据导出时查询方法)
	 * @param pSet
	 * @return DataSet
	 * @throws
	 * @author luguosui
	 */
	public DataSet queryForExport(ParameterSet pSet) {
		return fisFuneralOrganBuildareaDao.queryForExport(pSet);
	}
}
