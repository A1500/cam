package com.inspur.cams.drel.sam.domain;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.drel.sam.data.SamTreatmentAdjust;

/**
 * @title:待遇调整记录Domain接口
 * @description:
 * @author: zhangjian
 * @date:2012-06-06
 * @version:1.0
 */
public interface ISamTreatmentAdjustDomain {
	/**
	 * 查询
	 * 
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);
	@Trans
	public void batchInsert(List<SamTreatmentAdjust> samTreatmentAdjustList);
	@Trans
	public void insert(SamTreatmentAdjust samTreatmentAdjust);
}
