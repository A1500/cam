package com.inspur.cams.drel.sam.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;
import org.osoa.sca.annotations.Reference;
import com.inspur.cams.drel.sam.dao.ISamApplyFilesDao;
import com.inspur.cams.drel.sam.data.SamApplyFiles;
import com.inspur.cams.drel.sam.domain.ISamApplyFilesDomain;
/**
 * @title:申请材料Domain
 * @description:
 * @author: yanliangliang
 * @date:2012年5月16日
 * @version:1.0
 */
public class SamApplyFilesDomain implements ISamApplyFilesDomain {
	@Reference
	private ISamApplyFilesDao samApplyFilesDao;
	/**
	 * 增加申请材料
	 * @param samFamilyTreatment
	 */
	public void insert(SamApplyFiles samApplyFiles) {
		samApplyFilesDao.insert(samApplyFiles);
	}
	/**
	 * 查询申请材料
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return samApplyFilesDao.query(pset);
	}
	/**
	 * 更新申请材料
	 * @param samFamilyTreatment
	 */
	public void update(SamApplyFiles samApplyFiles) {
		samApplyFilesDao.update(samApplyFiles);
	}
	
	/**
	 * 更新附件
	 * @param samFamilyTreatment
	 */
	@Trans
	public void updateWithFile(SamApplyFiles samApplyFiles){
		samApplyFilesDao.updateWithFile(samApplyFiles);
	}
	
	/**
	 * 删除申请材料
	 * @param applyFileId
	 */
	public void delete(String applyFileId){
		samApplyFilesDao.delete(applyFileId);
	}
}
