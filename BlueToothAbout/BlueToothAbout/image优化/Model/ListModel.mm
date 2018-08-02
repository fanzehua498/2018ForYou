//
//  ListModel.m
//  BlueToothAbout
//
//  Created by 知合金服-Mini on 2018/7/11.
//  Copyright © 2018年 fanzehua. All rights reserved.
//

#import "ListModel.h"
#include <iostream>
//定义一个链表节点
typedef struct ListNodel{
    
    int m_nkey;
    struct ListNodel *m_pNext;
    
}ListNodel;


//创建链表
// *& 符号 可改变值 与 指针
void createList(ListNodel * &head,int data){
    
    //创建新节点
    ListNodel *newP = (ListNodel *)malloc(sizeof(ListNodel));
    newP->m_pNext = NULL;
    newP->m_nkey = data;
    
    if (head == NULL) {
        head = newP;
        return;
    }
    newP->m_pNext = head;
    head = newP;
}

//打印链表
void printList(ListNodel *head){
    
    ListNodel *p = head;
    while (p!= NULL) {
//        p->m_nkey << "";
        // c++ 打印方法
        std::cout << p->m_nkey << " ";
        p = p->m_pNext;
       
    }
    std::cout << std::endl;
}

//反转链表
//思路为将节点从前到后依次放到表头，最后最后的节点到了最前面,最前面的节点到了最后面
ListNodel* reverseList(ListNodel *head){
    
    //链表为空或链表只有一个元素
    if (head==NULL || head -> m_pNext == NULL) {
        return head;
    }
    //下一个节点
    ListNodel *p = head->m_pNext;
    ListNodel *headP = head;
    
    while (p != NULL) {
        headP->m_pNext = p->m_pNext;//记录下p的下一个节点
        p->m_pNext = head;
        head = p;
        p = headP->m_pNext;//准备将p的下一个节点放到表头
    }
    return head;
}

//递归方式
ListNodel * ReverseList2(ListNodel * head)
{
    //如果链表为空或者链表中只有一个元素
    if(head==NULL || head->m_pNext==NULL)
        return head;
    else
    {
        ListNodel * newhead=ReverseList2(head->m_pNext);//先反转后面的链表
        head->m_pNext->m_pNext=head;//再将当前节点设置为其然来后面节点的后续节点
        head->m_pNext=NULL;
        return newhead;
    }
}


@implementation ListModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        ListNodel *head = NULL;
        for (int i = 0; i < 10; i ++) {
            createList(head, i);
        }
        printList(head);
        
        ListNodel *NewHead = reverseList(head);
        printList(NewHead);
    }
    return self;
}

@end
