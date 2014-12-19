package com.inspur.cams.sorg.base.dao;

import org.loushang.next.dao.BaseCURD;
import com.inspur.cams.sorg.base.data.SomDutyElectronic;
/**
 * 职务与相关附件中间表Dao层接口
 * @author yanliangliang
 * @date 2011-12-17
 */
public interface ISomDutyElectronicDao extends BaseCURD<SomDutyElectronic>{
	/**
	 * 通过旧的dutyId更新为新的dutyId
	 * @param OldDutyId
	 * @param newDutyId
	 */
	public void updateDutyId(String oldDutyId,String newDutyId);
}
