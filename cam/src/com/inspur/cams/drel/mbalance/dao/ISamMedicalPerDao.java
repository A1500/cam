package com.inspur.cams.drel.mbalance.dao;

import java.util.List;

import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;

import com.inspur.cams.drel.mbalance.data.SamMedicalPer;
/***
 * 一站结算_救助比例dao
 * @author yanliangliang
 * @date 2011-6-15
 */
public interface ISamMedicalPerDao extends BaseCURD<SamMedicalPer> {
	public void save(List<SamMedicalPer> list);
	
	public DataSet queryPer(String domicileCode,String payBase,String assitanceType);

	
}
