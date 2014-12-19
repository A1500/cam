package com.inspur.cams.drel.sam.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;
import com.inspur.cams.drel.sam.data.SamApplyFiles;
/**
 * @title:申请材料Domain接口
 * @description:
 * @author: yanliangliang
 * @date:2012年5月16日
 * @version:1.0
 */
public interface ISamApplyFilesDomain {
	/**
	 * 查询申请材料
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 增加申请材料
	 * @param samFamilyTreatment
	 */
	@Trans
	public void insert(SamApplyFiles samApplyFiles);
	
	/**
	 * 更新申请材料
	 * @param samFamilyTreatment
	 */
	@Trans
	public void update(SamApplyFiles samApplyFiles);
	
	/**
	 * 更新附件
	 * @param samFamilyTreatment
	 */
	@Trans
	public void updateWithFile(SamApplyFiles samApplyFiles);
	
	/**
	 * 删除申请材料
	 * @param applyFileId
	 */
	@Trans
	public void delete(String applyFileId);
}
