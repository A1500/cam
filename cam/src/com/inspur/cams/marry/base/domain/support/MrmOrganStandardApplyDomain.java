package com.inspur.cams.marry.base.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.marry.base.dao.IMrmOrganStandardApplyDao;
import com.inspur.cams.marry.base.data.MrmOrganStandardApply;
import com.inspur.cams.marry.base.domain.IMrmOrganStandardApplyDomain;

/**
 * 婚姻登记机关等级评定标准业务表domain
 * @author 
 * @date 2012-11-28
 */
public class MrmOrganStandardApplyDomain implements IMrmOrganStandardApplyDomain {

	@Reference
	private IMrmOrganStandardApplyDao mrmOrganStandardApplyDao;

	/**
	 * 查询 婚姻登记机关等级评定标准业务表
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return mrmOrganStandardApplyDao.query(pset);
	}
	
	/**
	 * 查询，对result进行换行处理
	 * @param pset
	 * @return
	 */
	public DataSet queryApply(ParameterSet pset){
		DataSet ds= mrmOrganStandardApplyDao.query(pset);
		for (int i = 0; i < ds.getCount(); i++) {
			Record record=ds.getRecord(i);
			String result=(String) record.get("result");
			if (result!=null && !"".equals(result)) {
				StringBuffer resultBf=new StringBuffer();
				String[] resultArr=result.split("<BR>");
				for (int j = 0; j < resultArr.length; j++) {
					resultBf.append(resultArr[j]);
					resultBf.append(System.getProperty("line.separator"));
				}
				record.set("result", resultBf.toString().replace("<FONT color=red size=4>","").replace("<BR>","").replace("</FONT>",""));
			}
		}
		return ds;
	}

	/**
	 * 获取 婚姻登记机关等级评定标准业务表
	 * @param pset
	 * @return
	 */
	public MrmOrganStandardApply get(String applyId) {
		return mrmOrganStandardApplyDao.get(applyId);
	}

	/**
	 * 增加 婚姻登记机关等级评定标准业务表
	 * @param mrmOrganStandardApply
	 */
	public void insert(MrmOrganStandardApply mrmOrganStandardApply) {
		mrmOrganStandardApplyDao.insert(mrmOrganStandardApply);
	}
	
	/**
	 * 修改 婚姻登记机关等级评定标准业务表
	 * @param mrmOrganStandardApply
	 */
	public void update(MrmOrganStandardApply mrmOrganStandardApply) {
		mrmOrganStandardApplyDao.update(mrmOrganStandardApply);
	}
	
	/**
	 * 删除 婚姻登记机关等级评定标准业务表
	 * @param applyId
	 */
	public void delete(String applyId) {
		mrmOrganStandardApplyDao.delete(applyId);
	}

}