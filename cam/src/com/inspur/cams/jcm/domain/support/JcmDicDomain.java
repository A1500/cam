package com.inspur.cams.jcm.domain.support;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.jcm.dao.IJcmDicDao;
import com.inspur.cams.jcm.data.JcmDic;
import com.inspur.cams.jcm.domain.IJcmDicDomain;

/**
 * 字典管理表domain
 * @author
 * @date 2014-12-15
 */
public class JcmDicDomain implements IJcmDicDomain {

	@Reference
	private IJcmDicDao jcmDicDao;

	/**
	 * 查询 字典管理表
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return jcmDicDao.query(pset);
	}

	/**
	 * 获取 字典管理表
	 * @param pset
	 * @return
	 */
	public JcmDic get(String id) {
		return jcmDicDao.get(id);
	}

	/**
	 * 增加 字典管理表
	 * @param jcmDic
	 */
	public void insert(JcmDic jcmDic) {
		jcmDicDao.insert(jcmDic);
	}
	
	/**
	 * 修改 字典管理表
	 * @param jcmDic
	 */
	public void update(JcmDic jcmDic) {
		jcmDicDao.update(jcmDic);
	}
	
	/**
	 * 删除 字典管理表
	 * @param id
	 */
	public void delete(String id) {
		jcmDicDao.delete(id);
	}
	/**
	 * 保存 字典管理表
	 * @param equList
	 */
	public void save(List equList) {
		jcmDicDao.save(equList);
	}

}