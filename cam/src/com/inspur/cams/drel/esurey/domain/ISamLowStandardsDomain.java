package com.inspur.cams.drel.esurey.domain;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.drel.esurey.data.SamLowStandards;

public interface ISamLowStandardsDomain {
	
	public DataSet query(ParameterSet ps);
	public SamLowStandards get(String standardsId);
	@Trans
	public void save(List<SamLowStandards> list);
	@Trans
	public void batchDelete(String[] ids);
	@Trans
	public void insert(SamLowStandards dataBean);
	@Trans
	public void update(SamLowStandards dataBean);

	/**
	 * 停用某标准
	 * @param id
	 */
	@Trans
	public void unUse(String id);

}
