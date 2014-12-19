package com.inspur.cams.comm.extuser.domain.support;

import java.util.List;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.comm.extuser.dao.IComExtUserDao;
import com.inspur.cams.comm.extuser.data.ComExtUser;
import com.inspur.cams.comm.extuser.domain.IComExtUserDomain;
import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.sorg.base.data.SomOrgan;
import com.inspur.cams.sorg.online.extusermenu.dao.support.SomExtuserMenuDao;
import com.inspur.cams.sorg.online.extusermenu.data.SomExtuserMenu;

/**
 * 外部单位用户domain实现类
 * @author shgtch
 * @date 2011-6-29
 */
public class ComExtUserDomain implements IComExtUserDomain {

	// 外部单位用户dao
	@Reference
	private IComExtUserDao comExtUserDao;
	private SomExtuserMenuDao somExtuserMenuDao = (SomExtuserMenuDao) DaoFactory
	.getDao("com.inspur.cams.sorg.online.extusermenu.dao.support.SomExtuserMenuDao");
	/**
	 * 获取外部单位用户信息
	 * @param userId
	 * @return
	 */
	public ComExtUser getComExtUser(String userId) {
		return comExtUserDao.getComExtUser(userId);
	}

	/**
	 * 增加外部单位用户信息
	 * @param comExtUser
	 */
	@Trans
	public void insertComExtUser(ComExtUser comExtUser) {
		comExtUser.setCreatePeople(BspUtil.getEmpOrgan().getOrganName());
		comExtUser.setCreateTime(DateUtil.getTime());
		comExtUser.setInUse("1");
		comExtUserDao.insertComExtUser(comExtUser);
	}
	
	@Trans
	  public void insertUser(ComExtUser comExtUser)
	  {
	    this.comExtUserDao.insertComExtUser(comExtUser);
	  }
	@Trans
	public void deleteSelected(String[] delIds)
	  {
	    this.comExtUserDao.deleteSelected(delIds);
	  }

	  @Trans
	  public void saveUser(List list)
	  {
	    this.comExtUserDao.saveUser(list);
	  }
	  
	  @Trans
	  public void deleteUser(String userId)
	  {
	    this.comExtUserDao.delete(userId);
	  }
	/**
	 * 更新外部单位用户信息
	 * @param comExtUser
	 */
	@Trans
	public void updateComExtUser(ComExtUser comExtUser) {
		comExtUserDao.updateComExtUser(comExtUser);
	}

	/**
	 * 逻辑删除外部单位用户信息
	 * @param userId
	 */
	@Trans
	public void deleteComExtUser(String userId) {
		comExtUserDao.deleteComExtUser(userId);
	}

	/**
	 * 通用单位内码逻辑删除外部单位用户
	 * @param organId
	 */
	@Trans
	public void deleteComExtUserByOrganId(String organId) {
		comExtUserDao.deleteComExtUserByOrganId(organId);
	}

	/**
	 * 查询外部单位用户信息
	 * @param ps
	 * @return
	 */
	public DataSet queryExtUser(ParameterSet ps) {

		return comExtUserDao.queryExtUser(ps);
	}

	public void batchDelete(String[] delIds){
		for(int i=0;i<delIds.length;i++){
			comExtUserDao.delete(delIds[i]);
		}
	}

	public void delete(String userId) {
		// TODO Auto-generated method stub
		comExtUserDao.delete(userId);
	}

	public void updatePassWord(String userId, String passWord) {
		 comExtUserDao.updatePassWord(userId, passWord);
	}
	//批量解冻用户（社会组织江西年检用）
	public void batchUpdateComExtUser(List<ComExtUser> comExtUsers) {
		for(int i=0;i<comExtUsers.size();i++){
			ComExtUser comExtUser = (ComExtUser)comExtUsers.get(i);
			comExtUser.setIfFreeze("0");
			comExtUserDao.updateComExtUser(comExtUser);
		}

	}


	public void updateSomExtuserBychangge(String changgebefore,	String changgeafter) {
		// TODO Auto-generated method stub
		comExtUserDao.updateExtuserbychangge(changgebefore, changgeafter);
		comExtUserDao.updatesomExtuserMenubychangge(changgebefore, changgeafter);
	}

	public void updateSorgcode(String sorgcode,String cnName ) {
		comExtUserDao.updateSorgcode(sorgcode, cnName);
	}


	/**
	 * 通过成立登记创建外部用户
	 * 2014年3月20日
	 */
	public void createextuserbycl(SomOrgan organBean)
	{
//首先判断是否已经创建
	int count=	comExtUserDao.ifcreateextuser(organBean.getCnName());
      if(count==0)
      {
    	  ComExtUser  comExtUser=new ComExtUser();
    	  comExtUser.setUserId(organBean.getCnName());
    	  comExtUser.setUserName(organBean.getCnName());
    	  comExtUser.setAreaCode(organBean.getMorgArea());
    	  comExtUser.setInUse("1");
    	  comExtUser.setPwd("1");
    	  comExtUser.setAccountStatus("1");
    	  comExtUser.setIfCa("0");
    	  comExtUser.setCreatePeople(BspUtil.getEmpOrgan().getOrganName());
  		comExtUser.setCreateTime(DateUtil.getTime());
  		if(organBean.getSorgType().equals("S"))
    	  comExtUser.setOrganType("ST");
  		if(organBean.getSorgType().equals("M"))
      	  comExtUser.setOrganType("MF");
  		if(organBean.getSorgType().equals("J"))
      	  comExtUser.setOrganType("JJ");
        comExtUserDao.insertComExtUser(comExtUser);
    	   SomExtuserMenu somExtuserMenu=new SomExtuserMenu();
    		somExtuserMenu.setId(organBean.getCnName());
    		somExtuserMenu.setUserId(organBean.getCnName());
    		somExtuserMenu.setSorgCode(organBean.getSorgCode());
    		if(organBean.getSorgType().equals("S"))
    		somExtuserMenu.setMenuInfo("001,002,003,004,014,009,008,017,016");
    		if(organBean.getSorgType().equals("M"))
        		somExtuserMenu.setMenuInfo("100,101,102,103,108,114");
    		if(organBean.getSorgType().equals("J"))
        		somExtuserMenu.setMenuInfo("200,201,202,203,209,208,214,224");
    	  somExtuserMenuDao.insertmenu(somExtuserMenu);
      }

	}
}
