package com.inspur.cams.drel.mbalance.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.drel.mbalance.data.SamMedicalTopLine;

/***
 * 一站结算_救助封顶线domain接口
 * @author yanliangliang
 * @date 2011-6-15
 */
public interface ISamMedicalTopLineDomain {
	/**
	 * 救助封顶线查询
	 * @param pset
	 * @return 
	 */
	public DataSet query(ParameterSet pset);
	/**
	 * 救助封顶线的插入
	 * @param samMedicalTopLine
	 * @return
	 */
	@Trans
	public String insert(SamMedicalTopLine samMedicalTopLine);
	/**
	 * 救助封顶线的修改
	 * @param samMedicalTopLine
	 */
	@Trans
	public void update(SamMedicalTopLine samMedicalTopLine);
}
