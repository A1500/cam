package com.inspur.cams.fis.base.domain;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.fis.base.data.FisFacilitiesInfo;

/**
 * @Path com.inspur.cams.fis.base.domain.IFisFacilitiesInfoDomain
 * @Description: TODO 殡葬业务设施表domain接口
 * @author wangziming
 * @date 2011-11-15
 */
public interface IFisFacilitiesInfoDomain {

	public DataSet query(ParameterSet pset);

	public DataSet queryForsFacilitiesInfo(ParameterSet pset);

	public DataSet queryForFacilitiesService(ParameterSet pset);

	@Trans
	public void insert(FisFacilitiesInfo fisFacilitiesInfo);

	@Trans
	public void batchInsert(List<FisFacilitiesInfo> list);

	@Trans
	public void update(FisFacilitiesInfo fisFacilitiesInfo);

	@Trans
	public void batchUpdate(List<FisFacilitiesInfo> list);

	@Trans
	public void delete(String[] delIds);

	@Trans
	public void save(List<FisFacilitiesInfo> list);

	public DataSet queryForExport(ParameterSet set);
}