package com.inspur.cams.sorg.adm.summary.cmd;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.next.web.cmd.BaseAjaxCommand;

import com.inspur.cams.comm.util.StrUtil;
import com.inspur.cams.sorg.adm.summary.dao.SomSummaryQueryDao;
public class SomSummaryQuery extends BaseAjaxCommand {
	private SomSummaryQueryDao dao = (SomSummaryQueryDao) DaoFactory.getDao("com.inspur.cams.sorg.adm.summary.dao.SomSummaryQueryDao");
	/**
	 * 社会组织主表查询
	 */
	public void querySorgNumGrid(){
		String josn = "";
		ParameterSet pset = getParameterSet();
		DataSet ds = dao.querySorgNumGrid(pset);
		Record record = new Record();
		List arealist = new ArrayList();
		List numlist = new ArrayList();
		List sorgTypelist = new ArrayList();
		//柱状图所需数据
		String sStr = "";
		String mStr = "";
		String jStr = "";
		String titleStr = "";
		//柱状图所需数据定义结束
		int sumS =0;
		int sumM =0;
		int sumJ =0;
		for(int i=0;i<ds.getCount();i++){
			arealist.add(StrUtil.n2b((String)ds.getRecord(i).get("AREA")));
			numlist.add(StrUtil.n2b((String)((BigDecimal)ds.getRecord(i).get("SUMCOUNT")).toString()));
			sorgTypelist.add(StrUtil.n2b((String)ds.getRecord(i).get("SORG_TYPE")));
		}
		Map addMap = new HashMap();
		for(int i=0;i<ds.getCount();i++){
			int count=0;
			Record currenRecord = ds.getRecord(i);
			List sameNumList = new ArrayList();
			List sameSorgTypeList = new ArrayList();
			for(int listIndex = 0;listIndex<arealist.size();listIndex++){
				if(arealist.get(listIndex).equals(currenRecord.get("AREA"))){
					count++;
					sameNumList.add(numlist.get(listIndex));
					sameSorgTypeList.add(sorgTypelist.get(listIndex));
				}
			}
			String name = StrUtil.n2b((String)currenRecord.get("NAME"));
			String num = StrUtil.n2b(((BigDecimal)currenRecord.get("SUMCOUNT")).toString());
			String sorgType = StrUtil.n2b((String)currenRecord.get("SORG_TYPE"));
			if(count == 1){
				String s = "社会团体";
				String m = "民办非企业单位";
				String j = "基金会";
				if(sorgType.equals(s)){
					josn += "{"+getJsonHead("地区")+getJsonContent(name)+","+getJsonHead(s)+getJsonContent(num)+","+getJsonHead(m)+getJsonContent("0")+","+getJsonHead(j)+getJsonContent("0")+","+getJsonHead("合计")+getJsonContent(num)+"},";
					sumS+=Integer.parseInt(num);
					sStr+=num+",";
					titleStr +=name+",";
				}else
				if(sorgType.equals(m)){
					josn += "{"+getJsonHead("地区")+getJsonContent(name)+","+getJsonHead(s)+getJsonContent("0")+","+getJsonHead(m)+getJsonContent(num)+","+getJsonHead(j)+getJsonContent("0")+","+getJsonHead("合计")+getJsonContent(num)+"},";
					sumM+=Integer.parseInt(num);
					mStr+=num+",";
					titleStr +=name+",";
				}else
				if(sorgType.equals(j)){
					josn += "{"+getJsonHead("地区")+getJsonContent(name)+","+getJsonHead(s)+getJsonContent("0")+","+getJsonHead(m)+getJsonContent("0")+","+getJsonHead(j)+getJsonContent(num)+","+getJsonHead("合计")+getJsonContent(num)+"},";
					sumJ+=Integer.parseInt(num);
					jStr+=num+",";
					titleStr +=name+",";
				}else{
					josn += "{"+getJsonHead("地区")+getJsonContent(name)+","+getJsonHead(s)+getJsonContent("0")+","+getJsonHead(m)+getJsonContent("0")+","+getJsonHead(j)+getJsonContent("0")+","+getJsonHead("合计")+getJsonContent("0")+"},";
					sStr+=0+",";
					mStr+=0+",";
					jStr+=0+",";
					titleStr +=name+",";
				}
			}
			if(count == 2){
				if(addMap.get(name)==null){
					josn = josn+"{"+getJsonHead("地区")+getJsonContent(name)+",";
					int sum = 0;
					String tempJsonS =getJsonHead("社会团体")+getJsonContent("0")+",";
					String tempJsonM = getJsonHead("民办非企业单位")+getJsonContent("0")+",";
					String tempJsonJ =getJsonHead("基金会")+getJsonContent("0")+",";
					for(int j=0;j<sameSorgTypeList.size();j++){
						sum+=Integer.parseInt((String)sameNumList.get(j));
						if(sameSorgTypeList.get(j).equals("社会团体")){
							tempJsonS =  getJsonHead("社会团体")+getJsonContent((String)sameNumList.get(j))+",";
							sumS+=Integer.parseInt(sameNumList.get(j)+"");
							sStr+=sameNumList.get(j)+",";
						}
						if(sameSorgTypeList.get(j).equals("民办非企业单位")){
							tempJsonM =  getJsonHead("民办非企业单位")+getJsonContent((String)sameNumList.get(j))+",";
							sumM+=Integer.parseInt(sameNumList.get(j)+"");
							mStr+=sameNumList.get(j)+",";
						}
						if(sameSorgTypeList.get(j).equals("基金会")){
							tempJsonJ =  getJsonHead("基金会")+getJsonContent((String)sameNumList.get(j))+",";
							sumJ+=Integer.parseInt(sameNumList.get(j)+"");
							jStr+=sameNumList.get(j)+",";
						}
					}
					titleStr +=name+",";
					josn =josn+tempJsonS+tempJsonM+tempJsonJ;
					josn =josn+getJsonHead("合计")+getJsonContent(sum+"")+"},";
					addMap.put(name, "true");
				}
				
			}
			
			if(count == 3){
				if(addMap.get(name)==null){
					josn =josn+ "{"+getJsonHead("地区")+getJsonContent(name)+",";
					int sum = 0;
					String tempJsonS =getJsonHead("社会团体")+getJsonContent("0")+",";
					String tempJsonM = getJsonHead("民办非企业单位")+getJsonContent("0")+",";
					String tempJsonJ =getJsonHead("基金会")+getJsonContent("0")+",";
					for(int j=0;j<sameSorgTypeList.size();j++){
						if(sameSorgTypeList.get(j).equals("社会团体")){
							tempJsonS =  getJsonHead("社会团体")+getJsonContent((String)sameNumList.get(j))+",";
							sumS+=Integer.parseInt(sameNumList.get(j)+"");
							sStr+=sameNumList.get(j)+",";
						}
						if(sameSorgTypeList.get(j).equals("民办非企业单位")){
							tempJsonM =  getJsonHead("民办非企业单位")+getJsonContent((String)sameNumList.get(j))+",";
							sumM+=Integer.parseInt(sameNumList.get(j)+"");
							mStr+=sameNumList.get(j)+",";
						}
						if(sameSorgTypeList.get(j).equals("基金会")){
							tempJsonJ =  getJsonHead("基金会")+getJsonContent((String)sameNumList.get(j))+",";
							sumJ+=Integer.parseInt(sameNumList.get(j)+"");
							jStr+=sameNumList.get(j)+",";
						}
						sum+=Integer.parseInt((String)sameNumList.get(j));
					}
					titleStr +=name+",";
					josn =josn+tempJsonS+tempJsonM+tempJsonJ;
					josn =josn+getJsonHead("合计")+getJsonContent(sum+"")+"},";
					addMap.put(name, "true");
				}
				
			}
		}
		josn = "{"+getJsonHead("地区")+getJsonContent("山东省")+","+getJsonHead("合计")+getJsonContent((sumJ+sumS+sumM)+"")+","+getJsonHead("社会团体")+getJsonContent(sumS+"")+","+getJsonHead("民办非企业单位")+getJsonContent(sumM+"")+","+getJsonHead("基金会")+getJsonContent(sumJ+"")+"},"+josn;
		josn = "{\"total\":18,\"rows\":["+josn.substring(0,josn.length()-1)+"]}";
		setReturn("numJosn", josn);
		setReturn("sStr", sStr.substring(0,sStr.length()-1));
		setReturn("mStr", mStr.substring(0,mStr.length()-1));
		setReturn("jStr", jStr.substring(0,jStr.length()-1));
		setReturn("titleStr", titleStr.substring(0,titleStr.length()-1));
	}
	public void querySorgAddCancelNumGrid(){
		ParameterSet pset = getParameterSet();
		DataSet addDs = dao.queryAddNumGrid(pset);
		String addStr = "";
		String cancelStr = "";
		for(int i=0;i<addDs.getCount();i++){
			addStr+=addDs.getRecord(i).get("COUNTNUM")+",";
		}
		DataSet cancelDs = dao.queryCancelNumGrid(pset);
		for(int i=0;i<cancelDs.getCount();i++){
			cancelStr+=cancelDs.getRecord(i).get("COUNTNUM")+",";
		}
		setReturn("addStr", addStr.substring(0,addStr.length()-1));
		setReturn("cancelStr", cancelStr.substring(0,cancelStr.length()-1));
	}
	
	public void querySorgKindPie(){
		ParameterSet pset = getParameterSet();
		DataSet ds = dao.querySorgKindPie(pset);
		String xs = "0";
		String hy = "0";
		String zy = "0";
		String lh = "0";
		for(int i=0;i<ds.getCount();i++){
			if(ds.getRecord(i).get("SORG_KIND").equals("1")){
				xs=(String)ds.getRecord(i).get("COUNT").toString();
			}
			if(ds.getRecord(i).get("SORG_KIND").equals("2")){
				hy=(String)ds.getRecord(i).get("COUNT").toString();
			}
			if(ds.getRecord(i).get("SORG_KIND").equals("3")){
				zy=(String)ds.getRecord(i).get("COUNT").toString();
			}
			if(ds.getRecord(i).get("SORG_KIND").equals("4")){
				lh=(String)ds.getRecord(i).get("COUNT").toString();
			}
		}
		setReturn("xs", xs);
		setReturn("hy", hy);
		setReturn("zy", zy);
		setReturn("lh", lh);
	}
	
	private static String  dataSet2Json(DataSet ds){
		
		return "";
	}
	
	private static String getJsonHead(String str){
		return "\""+str+"\":";
	}
	
	private static String getJsonContent(String str){
		return "\""+str+"\"";
	}
	
}
