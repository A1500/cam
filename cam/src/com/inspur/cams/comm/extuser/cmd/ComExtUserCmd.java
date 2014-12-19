package com.inspur.cams.comm.extuser.cmd;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.cdc.base.data.CdcUnderGovemnsInfo;
import com.inspur.cams.cdc.base.domain.ICdcUnderGovemnsInfoDomain;
import com.inspur.cams.comm.extuser.data.ComExtUser;
import com.inspur.cams.comm.extuser.domain.IComExtUserDomain;

/**
 * 外部单位用户cmd
 * @author shgtch
 * @date 2011-6-29
 */
public class ComExtUserCmd extends BaseAjaxCommand {

	// 外部单位用户domain
	private IComExtUserDomain comExtUserDomain = (IComExtUserDomain) ScaComponentFactory.getService(IComExtUserDomain.class, "comExtUserDomain/comExtUserDomain");
	// 下辖村表domain
	private ICdcUnderGovemnsInfoDomain cdcUnderGovemnsInfoDomain = (ICdcUnderGovemnsInfoDomain) ScaComponentFactory.getService(ICdcUnderGovemnsInfoDomain.class, "cdcUnderGovemnsInfoDomain/cdcUnderGovemnsInfoDomain");
	
	/**
	 * 增加外部单位用户
	 */
	public void insert() {
		Record record = (Record) getParameter("comExtUser");
		ComExtUser comExtUser = (ComExtUser) record.toBean(ComExtUser.class);
		comExtUserDomain.insertComExtUser(comExtUser);
	}
	
	/**
	 * 增加外部单位用户
	 */
	public void insertUser() {
		Record record = (Record) getParameter("record");
		ComExtUser comExtUser = (ComExtUser) record.toBean(ComExtUser.class);
		comExtUserDomain.insertUser(comExtUser);
	}
	
	/**
	 * 增加下辖村管理
	 */
	public void saveUser() {
		Record[] records = (Record[]) getParameter("records");
		List<ComExtUser> list = new ArrayList<ComExtUser>();
		List<CdcUnderGovemnsInfo> villageList = new ArrayList<CdcUnderGovemnsInfo>();
		
		for (int i = 0; i < records.length; i++) {
			ComExtUser dataBean = (ComExtUser) records[i].toBean(ComExtUser.class);
			//保存下辖村关联关系
			dataBean.setAccountStatus("1");
			dataBean.setInUse("1");
			list.add(dataBean);
			
		}
		comExtUserDomain.saveUser(list);
	}
	
	/**
	 * 修改外部单位用户
	 */
	public void update() {
		Record record = (Record) getParameter("comExtUser");
		ComExtUser comExtUser = (ComExtUser) record.toBean(ComExtUser.class);
		comExtUserDomain.updateComExtUser(comExtUser);
	}

	/**
	 * 逻辑删除外部单位用户
	 */
	public void delete() {
		String userId = (String) getParameter("userId");
		comExtUserDomain.deleteComExtUser(userId);
	}
	
	/**
	 * 删除用户
	 */
	public void deleteUser() {
		String userId = (String) getParameter("userId");
		ParameterSet pset = new ParameterSet();
		pset.setParameter("USER_ID@=", userId);
		DataSet ds = comExtUserDomain.queryExtUser(pset);
		ComExtUser userBean =(ComExtUser) ds.getRecord(0).toBean(ComExtUser.class);
		String areaCode=userBean.getAreaCode();
		
		ParameterSet pset2 = new ParameterSet();
		pset2.setParameter("ORGAN_ID@=", areaCode);
		DataSet underDs = comExtUserDomain.queryExtUser(pset2);
		if(underDs.getCount()>0){
			this.setReturn("tips", "请先删除下辖的村");
		}else{
			comExtUserDomain.deleteUser(userId);
		}
	}
	
	/**
	 * 删除用户
	 */
	public void deleteSelected() {
		String[] delIds=(String[]) getParameter("delIds");
		//删除用户表信息
		comExtUserDomain.deleteSelected(delIds);
		//删除下辖村表的信息
		cdcUnderGovemnsInfoDomain.batchDelete(delIds);
	}
	
	public void del() {
		String[] delIds=(String[]) getParameter("delIds");
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
}
