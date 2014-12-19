package com.inspur.cams.sorg.online.extuser.cmd;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.comm.extuser.data.ComExtUser;
import com.inspur.cams.comm.extuser.domain.IComExtUserDomain;
import com.inspur.cams.sorg.online.extusermenu.dao.support.SomExtuserMenuDao;
import com.inspur.cams.sorg.online.extusermenu.data.SomExtuserMenu;

public class SomExtUserCmd extends BaseAjaxCommand {

	// 外部单位用户domain
	private IComExtUserDomain comExtUserDomain = (IComExtUserDomain) ScaComponentFactory.getService(IComExtUserDomain.class, "comExtUserDomain/comExtUserDomain");
	
	private SomExtuserMenuDao somExtuserMenuDao = (SomExtuserMenuDao) DaoFactory
	.getDao("com.inspur.cams.sorg.online.extusermenu.dao.support.SomExtuserMenuDao");
	/**
	 * 增加外部单位用户
	 */
	@Trans
	public void insert() {
		Record record = (Record) getParameter("comExtUser");
		ComExtUser comExtUser = (ComExtUser) record.toBean(ComExtUser.class);
		Record menuRecord = (Record) getParameter("menuRecord");
		SomExtuserMenu somExtuserMenu = (SomExtuserMenu) menuRecord.toBean(SomExtuserMenu.class);
		somExtuserMenu.setId(comExtUser.getUserId());
		somExtuserMenu.setUserId(comExtUser.getUserId());
		somExtuserMenuDao.insert(somExtuserMenu);
		comExtUserDomain.insertComExtUser(comExtUser);
	}
	
	/**
	 * 修改外部单位用户
	 */
	@Trans
	public void update() {
		Record record = (Record) getParameter("comExtUser");
		String initUserId = (String)getParameter("initUserId");
		ComExtUser comExtUser = (ComExtUser) record.toBean(ComExtUser.class);
		Record menuRecord = (Record) getParameter("menuRecord");
		SomExtuserMenu somExtuserMenu = (SomExtuserMenu) menuRecord.toBean(SomExtuserMenu.class);
		//支持修改时修改userid，此处先删除之前的comExtUser，然后插入
		comExtUserDomain.delete(initUserId);
		comExtUserDomain.insertComExtUser(comExtUser);
		//关联需要将menu中的userId修改为最新的
		somExtuserMenu.setUserId(comExtUser.getUserId());
		somExtuserMenuDao.update(somExtuserMenu);
		
	}

	/**
	 * 逻辑删除外部单位用户
	 */
	@Trans
	public void delete() {
		String userId = (String) getParameter("userId");
		somExtuserMenuDao.deleteSomExtUserMenu(userId);
		comExtUserDomain.deleteComExtUser(userId);
	}
	
	@Trans
	public void del() {
		String[] delIds=(String[]) getParameter("delIds");
		somExtuserMenuDao.batchDelete(delIds);
		comExtUserDomain.batchDelete(delIds);
	}
	/**
	 * 龙头企业修改密码
	 */
	public void updatePassWord() {
		String userId=(String) getParameter("userId");
		String passWord=(String) getParameter("passWord");
		comExtUserDomain.updatePassWord(userId, passWord);
	}
	//批量解冻用户（社会组织江西年检用）
	public void batchUpdate(){
		Record[] records = (Record[]) getParameter("comExtUser");
		if( records != null ){
			List<ComExtUser> comExtUsers = new ArrayList<ComExtUser>(); 
			for(int i=0;i<records.length;i++){
				ComExtUser comExtUser = (ComExtUser) records[i].toBean(ComExtUser.class);
				comExtUsers.add(comExtUser);
			}
			comExtUserDomain.batchUpdateComExtUser(comExtUsers);
		}
		
		
	}
	
	/**
	 * 检查用户名是否存在
	 */
	public void  checkUserId(){
		String status = "false";
		ParameterSet pset = getParameterSet();
		DataSet ds = comExtUserDomain.queryExtUser(pset);
		if(ds.getCount()>0){
			status = "true";
		}
		setReturn("status",status);		
	}
}
