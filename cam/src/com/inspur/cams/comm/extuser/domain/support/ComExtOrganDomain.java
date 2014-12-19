package com.inspur.cams.comm.extuser.domain.support;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.comm.extuser.dao.IComExtOrganDao;
import com.inspur.cams.comm.extuser.dao.IComExtUserDao;
import com.inspur.cams.comm.extuser.data.ComExtOrgan;
import com.inspur.cams.comm.extuser.domain.IComExtOrganDomain;
import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;

/**
 * 外部单位domain实现类
 * @author shgtch
 * @date 2011-6-29
 */
public class ComExtOrganDomain implements IComExtOrganDomain {

	// 外部单位dao
	@Reference
	private IComExtOrganDao comExtOrganDao;
	// 外部单位用户dao
	@Reference
	private IComExtUserDao comExtUserDao;
	
	/**
	 * 获取外部单位信息
	 * @param userId
	 * @return
	 */
	public ComExtOrgan getComExtOrgan(String organId) {
		return comExtOrganDao.getComExtOrgan(organId);
	}
	
	/**
	 * 增加外部单位信息
	 * @param comExtUser
	 */
	@Trans
	public ComExtOrgan insertComExtOrgan(ComExtOrgan comExtOrgan) {
		comExtOrgan.setOrganId(IdHelp.getUUID30());
		comExtOrgan.setCreatePeople(BspUtil.getEmpOrgan().getOrganName());
		comExtOrgan.setCreateTime(DateUtil.getTime());
		comExtOrgan.setInUse("1");
		comExtOrganDao.insertComExtOrgan(comExtOrgan);
		return comExtOrgan;
	}
	
	/**
	 * 更新外部单位信息
	 * @param comExtUser
	 */
	@Trans
	public void updateComExtOrgan(ComExtOrgan comExtOrgan) {
		comExtOrganDao.updateComExtOrgan(comExtOrgan);
	}
	
	/**
	 * 逻辑删除外部单位信息
	 * @param userId
	 */
	@Trans
	public void deleteComExtOrgan(String organId) {
		comExtUserDao.deleteComExtUserByOrganId(organId);
		comExtOrganDao.deleteComExtOrgan(organId);
	}
	
	/**
	 * 查询外部单位信息
	 * @param ps
	 * @return
	 */
	public DataSet queryExtOrgan(ParameterSet ps) {
		return comExtOrganDao.queryExtOrgan(ps);
	}
	
}
