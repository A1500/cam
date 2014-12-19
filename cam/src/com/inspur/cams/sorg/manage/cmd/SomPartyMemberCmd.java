package com.inspur.cams.sorg.manage.cmd;

import java.util.ArrayList;
import java.util.List;

import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.sorg.base.data.SomPartyMember;
import com.inspur.cams.sorg.base.data.SomPartyPraise;
import com.inspur.cams.sorg.manage.domain.ISomPartyOrganDomain;
/**
 * 
 * @author Jiangzhaobao
 *
 * @date 2011-6-8
 */
public class SomPartyMemberCmd extends BaseAjaxCommand{
	private ISomPartyOrganDomain service = ScaComponentFactory.getService(ISomPartyOrganDomain.class, "somPartyOrganDomain/somPartyOrganDomain");
	
	/**
	 * 增加党员
	 */
	public void insertPartyMember(){
		Record record=(Record)getParameter("somPartyMember");
		Record[] somPartyPraiseRecords=(Record[])getParameter("somPartyPraiseRecords");
		SomPartyMember dataBean =(SomPartyMember)record.toBean(SomPartyMember.class);		
		if (somPartyPraiseRecords != null) {
			List<SomPartyPraise> somPartyPraiseList = new ArrayList<SomPartyPraise>();
			for (int j = 0; j < somPartyPraiseRecords.length; j++) {
				SomPartyPraise somPartyPraise = (SomPartyPraise) somPartyPraiseRecords[j].toBean(SomPartyPraise.class);
				if (somPartyPraise.getMemberId().equals(dataBean.getMemberId())) {
					somPartyPraiseList.add(somPartyPraise);							
				}
			}
			dataBean.setSomPartyPraiseList(somPartyPraiseList);
		}
		service.insertPartyMember(dataBean);
	}
	/**
	 * 更新党员
	 */
	public void updatePartyMember(){
		Record record=(Record)getParameter("somPartyMember");
		Record[] somPartyPraiseRecords=(Record[])getParameter("somPartyPraiseRecords");
		SomPartyMember dataBean =(SomPartyMember)record.toBean(SomPartyMember.class);	
		if (somPartyPraiseRecords != null) {
			List<SomPartyPraise> somPartyPraiseList = new ArrayList<SomPartyPraise>();
			for (int j = 0; j < somPartyPraiseRecords.length; j++) {
				SomPartyPraise somPartyPraise = (SomPartyPraise) somPartyPraiseRecords[j].toBean(SomPartyPraise.class);
				if (somPartyPraise.getMemberId().equals(dataBean.getMemberId())) {
					somPartyPraiseList.add(somPartyPraise);							
				}
			}
			dataBean.setSomPartyPraiseList(somPartyPraiseList);
		}
		service.updatePartyMember(dataBean);
	}
	/**
	 * 党员转出信息维护
	 */
	public void saveOutInfo(){
		Record record = (Record)getParameter("somPartyMember");
		String outTime = (String)getParameter("outTime");
		String outToOrgan = (String)getParameter("outToOrgan");
		SomPartyMember somPartyMember =(SomPartyMember)record.toBean(SomPartyMember.class);
		somPartyMember.setOutTime(outTime);
		somPartyMember.setOutToOrgan(outToOrgan);
		somPartyMember.setOutType("0");
		service.saveMemberOutInfo(somPartyMember);
	}
	public void delPartyMember(){
		String memberId=(String)getParameter("memberId");
		service.delPartyMember(memberId);
	}
	/**
	 * 给页面返回一个新生成的memberId
	 */
	public void getMemberId(){
		setReturn("memberId", IdHelp.getUUID32());
	}
	
	/**
	 * 维护党员状态
	 */
	public void saveStatusChangeInfo(){
		Record record = (Record)getParameter("somPartyMember");
		String memberStatus = (String)getParameter("memberStatus");
		String statusChangeDate = (String)getParameter("statusChangeDate");
		SomPartyMember somPartyMember =(SomPartyMember)record.toBean(SomPartyMember.class);
		somPartyMember.setMemberStatus(memberStatus);
		somPartyMember.setStatusChangeDate(statusChangeDate);
		service.saveMemberStatusChangeInfo(somPartyMember);
	}
}
