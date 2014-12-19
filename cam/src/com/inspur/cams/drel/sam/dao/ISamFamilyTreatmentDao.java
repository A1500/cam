package com.inspur.cams.drel.sam.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.drel.sam.data.SamFamilyTreatment;

/**
 * @title:家庭待遇信息Dao
 * @description:
 * @author: yanll
 * @since:2012-05-03
 * @version:1.0
 */
public interface ISamFamilyTreatmentDao extends BaseCURD<SamFamilyTreatment> {
	public void save(List<SamFamilyTreatment> list);

	public DataSet queryAdjustList(ParameterSet pset);

	/**
	 * 身份证校验的时候查询待遇表，看是否正在进行救助
	 * 
	 * @param pset
	 *            FAMILY_ID
	 * @return
	 */
	public DataSet queryForCheckIDCard(ParameterSet pset);

	/**
	 * 调整所有保障金
	 * 
	 * @param pset
	 */
	public void updateAllAssistanceMoney(ParameterSet pset);

	public void deleteTreatment(String familyId);
}
