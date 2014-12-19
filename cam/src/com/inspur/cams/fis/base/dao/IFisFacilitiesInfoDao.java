package com.inspur.cams.fis.base.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.fis.base.data.FisFacilitiesInfo;

/**
 * @Path com.inspur.cams.fis.base.dao.IFisFacilitiesInfoDao
 * @Description: TODO 殡葬业务设施表dao接口
 * @author wangziming
 * @date 2011-11-15
 */
public interface IFisFacilitiesInfoDao extends BaseCURD<FisFacilitiesInfo> {
	public void save(List<FisFacilitiesInfo> list);

	public DataSet queryForsFacilitiesInfo(ParameterSet pset);

	public DataSet queryForFacilitiesService(ParameterSet pset);

	public DataSet queryForExport(ParameterSet set);
}
